#!/usr/bin/env bash

echo "Building php:5.6-fpm-wordpress"
docker build -t docker.rodeopartners.com/php:5.6-fpm-wordpress 5.6/fpm/wordpress
