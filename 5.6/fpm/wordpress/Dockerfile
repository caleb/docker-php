FROM php:5.6-fpm

# Install modules
RUN apt-get update && apt-get install -y \
    file libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libmemcached-dev \
    && docker-php-ext-install mcrypt mysql mysqli gd \
    && echo "" | pecl install -a memcached \
    && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
