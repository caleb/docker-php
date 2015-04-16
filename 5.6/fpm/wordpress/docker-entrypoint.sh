#!/usr/bin/env bash
set -e

export WORDPRESS_DIR

: ${WORDPRESS_DIR:=/srv/wordpress}

if [ -z "${WORDPRESS_DIR}" ] || [ ! -d "${WORDPRESS_DIR}" ] || [ ! -d "${WORDPRESS_DIR}/wp-admin" ]; then
  echo "Either WORDPRESS_DIR isn't set, or doesn't point to a wordpress directory (i.e. one that contains a wp-admin directory)"
  exit 1
fi

. /helpers/links.sh
require-link MYSQL mysql 3306 tcp
read-link MEMCACHED memcached 11211 tcp

# Add an include file that contains the database credentials and secreta and
# other constants
env_file="${WORDPRESS_DIR}/env.php"

echo "<?php" > $env_file

# If the user didn't specify a database host sniff one our for them
if [ -z "${DB_HOST}" ] && [ -n "${MYSQL_ADDR}" ]; then
  export DB_HOST=${MYSQL_ADDR}
fi

# Raw (unquoted) variables
while read -u 10 var; do
  value="${!var}"
  if [ -n "${!var}" ]; then
    # downcase true/false/null values to be valid php keywords
    if [ "${value,,}" = "true" ] || [ "${value,,}" = "false" ] || [ "${value,,}" = "null" ]; then
      echo "define('${var}', ${value,,});" >> $env_file
    else
      echo "define('${var}', ${value});" >> $env_file
    fi
  fi
done 10< /tmp/wordpress_constants/raw

# Quoted variables
while read -u 10 var; do
  value="${!var}"
  if [ -n "${!var}" ]; then
    echo "define('${var}', '${value}');" >> $env_file
  fi
done 10< /tmp/wordpress_constants/quoted

# Values that are either numbers or strings (e.g. permissions 0744 or 'u+rwx' or
# byte sizes: 123429 or '12M')
while read -u 10 var; do
  value="${!var}"
  if [ -n "${!var}" ]; then
    if [[ "${value}" =~ ^[0-9]+$ ]]; then
      echo "define('${var}', ${value});" >> $env_file
    else
      echo "define('${var}', '${value}');" >> $env_file
    fi
  fi
done 10< /tmp/wordpress_constants/number_or_string

# Generate the salts and keys
if [ -z "${SKIP_KEY_GENERATION}" ]; then
  curl https://api.wordpress.org/secret-key/1.1/salt/ >> $env_file
fi

echo "?>" >> $env_file

exec /fpm-entrypoint.sh "${@}"
