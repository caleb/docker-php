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
    echo "define('${const_name}', '${value}');" >> $env_file
  fi
done

# If there is a memcached server, turn on WP_CACHE so WP-FFPC is enabled
if [ -n "${MEMCACHED_ADDR}" ] && [ -n "${MEMCACHED_PORT}" ]; then
  echo "define('WP_CACHE', true);" >> $env_file
fi

echo "?>" >> $env_file

exec /fpm-entrypoint.sh "${@}"
