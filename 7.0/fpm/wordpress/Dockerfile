FROM caleb/php:7.0-fpm

# Install memcached modules
RUN apt-get update && apt-get install -y libmemcached-dev \
&&  echo "" | pecl install -a memcached \
&&  echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini \
&&  rm -rf /var/lib/apt/lists/*

# Move the fpm entrypoint out of the way so we can have our own and call it
RUN mv /entrypoint.sh /fpm-entrypoint.sh
ADD docker-entrypoint.sh /entrypoint.sh

ADD wordpress_constants /tmp/wordpress_constants
