FROM php:5.6-fpm

ENV PHP_FPM_PORT=9000 \
PHP_FPM_MAX_CHILDREN=5 \
PHP_FPM_START_SERVERS=2 \
PHP_FPM_MIN_SPARE_SERVERS=1 \
PHP_FPM_MAX_SPARE_SERVERS=3 \
PHP_FPM_UPLOAD_MAX_FILESIZE=2M \
PHP_FPM_POST_MAX_SIZE=8M

ADD https://raw.githubusercontent.com/caleb/mo/master/mo /usr/local/bin/mo

# Install modules
RUN apt-get update && apt-get install -y \
    file libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev  \
 && docker-php-ext-install mcrypt mysql mysqli gd \
 && mkdir /usr/local/etc/php/fpm \
 && chmod +x /usr/local/bin/mo

COPY php-fpm.conf.mo /usr/local/etc/php-fpm.conf.mo
COPY docker-entrypoint.sh /entrypoint.sh
COPY php.ini.mo /usr/local/etc/php/fpm/php.ini.mo

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
