FROM docker.rodeopartners.com/php:5.6-fpm

# Install memcached modules
RUN apt-get update && apt-get install -y libmemcached-dev \
&&  echo "" | pecl install -a memcached \
&&  echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini \
&&  rm -rf /var/lib/apt/lists/*
