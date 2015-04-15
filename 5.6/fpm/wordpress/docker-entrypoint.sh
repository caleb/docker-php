#!/usr/bin/env bash
set -e

. /helpers/links.sh
require-link MYSQL mysql 3306 tcp
read-link MEMCACHED memcached 11211 tcp

# Add an include file that contains the database credentials and secreta and
# other constants
env_file=/wordpress-settings.php

echo "<?php" >> $env_file

for var in ${!WORDPRESS_*}; do
  value="${!var}"
  if [[ "${var}" =~ ^WORDPRESS_(.*)$ ]]; then
    const_name="${BASH_REMATCH[1]}"

    if [[ "${const_name}" =~ ^UNQUOTED_(.*)$ ]]; then
      const_name="${BASH_REMATCH[1]}"

      # Boolean values come from docker-compose as False and True
      # make sure we downcase them
      if [ "${value,,}" = true ] || [ "${value,,}" = false ]; then
        value="${value,,}"
      fi
    else
      value="'${value}'"
    fi

    echo "define('${const_name}', ${value});" >> $env_file
  fi
done

echo "?>" >> $env_file

exec /fpm-entrypoint.sh "${@}"
