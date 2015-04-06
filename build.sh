#!/usr/bin/env bash

echo "Building php:5.6-fpm"
cd 5.6/fpm
./build.sh
cd ../..
docker tag -f docker.rodeopartners.com/php:5.6-fpm docker.rodeopartners.com/php:latest-fpm

echo "Building php:5.6-fpm-wordpress"
cd 5.6/fpm/wordpress
./build.sh
cd ../../..
docker tag -f docker.rodeopartners.com/php:5.6-fpm-wordpress docker.rodeopartners.com/php:latest-fpm-wordpress
