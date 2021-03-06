FROM php:7.0-fpm

ENV DOCKER_HELPERS_VERSION=1.0

# Download our docker helpers
ADD https://github.com/caleb/docker-helpers/releases/download/v${DOCKER_HELPERS_VERSION}/helpers-v${DOCKER_HELPERS_VERSION}.tar.gz /tmp/helpers.tar.gz

# Install the docker helpers
RUN mkdir -p /helpers \
&&  tar xzf /tmp/helpers.tar.gz -C / \
&&  rm /tmp/helpers.tar.gz

# Install the base system
RUN /bin/bash /helpers/install-base.sh

ENV PHP_FPM_PORT=9000 \
PHP_FPM_MAX_CHILDREN=5 \
PHP_FPM_START_SERVERS=2 \
PHP_FPM_MIN_SPARE_SERVERS=1 \
PHP_FPM_MAX_SPARE_SERVERS=3 \
PHP_FPM_UPLOAD_MAX_FILESIZE=2M \
PHP_FPM_POST_MAX_SIZE=8M

# Install modules
RUN apt-get update && apt-get install -y libgd-dev file libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev \
&&  docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
&&  docker-php-ext-install mcrypt mysqli gd \
&&  rm -rf /var/lib/apt/lists/*

# Enable opcode caching
RUN echo "zend_extension=opcache.so" > /usr/local/etc/php/conf.d/ext-opcache.ini

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
  echo 'opcache.memory_consumption=128'; \
  echo 'opcache.interned_strings_buffer=8'; \
  echo 'opcache.max_accelerated_files=4000'; \
  echo 'opcache.revalidate_freq=60'; \
  echo 'opcache.fast_shutdown=1'; \
  echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

COPY php-fpm.conf.mo /usr/local/etc/php-fpm.conf.mo
COPY docker-entrypoint.sh /entrypoint.sh
COPY php.ini.mo /usr/local/etc/php/php.ini.mo

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
