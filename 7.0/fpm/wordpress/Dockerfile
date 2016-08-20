FROM caleb/php:7.0-fpm

# Install memcached modules
RUN apt-get update && apt-get install -y libmemcached-dev git \
&&  cd / \
&&  git clone https://github.com/php-memcached-dev/php-memcached.git \
&&  cd php-memcached \
&&  git checkout php7 \
&&  phpize \
&&  ./configure \
&&  make \
&&  make install \
&&  echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini \
&&  rm -rf /var/lib/apt/lists/*

# Move the fpm entrypoint out of the way so we can have our own and call it
RUN mv /entrypoint.sh /fpm-entrypoint.sh
ADD docker-entrypoint.sh /entrypoint.sh

ADD wordpress_constants /tmp/wordpress_constants
