FROM php:5.6-fpm

# Install modules
RUN apt-get update && apt-get install -y \
    file libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev \
    && docker-php-ext-install mcrypt mysql mysqli gd

CMD ["php-fpm"]
