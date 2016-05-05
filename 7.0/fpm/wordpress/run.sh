#!/usr/bin/env bash

docker run -it --rm --name php-fpm -e PHP_FPM_UPLOAD_MAX_FILESIZE=100M \
       -e PHP_FPM_POST_MAX_SIZE=100M \
       caleb/php:7.0-fpm-wordpress
