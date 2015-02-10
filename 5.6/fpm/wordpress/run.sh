#!/usr/bin/env bash

docker run -it --rm --name php-fpm -e PHP_FPM_UPLOAD_MAX_FILESIZE=100M \
       -e PHP_FPM_POST_MAX_SIZE=100M \
       docker.rodeopartners.com/php:5.6-fpm-wordpress
