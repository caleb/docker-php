FROM php:5.6-fpm

ADD https://raw.githubusercontent.com/caleb/mo/master/mo /usr/local/bin/mo

# Install modules
RUN apt-get update && apt-get install -y \
    file libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev  \
 && docker-php-ext-install mcrypt mysql mysqli gd \
 && chmod +x /usr/local/bin/mo

COPY php-fpm.conf.mo /usr/local/etc/php-fpm.conf.mo
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
