#!/usr/bin/env bash

echo "Building php:5.6-fpm"
cd 5.6/fpm
./build.sh
cd ../..
docker tag -f caleb/php:5.6-fpm caleb/php:latest-fpm

echo "Building php:5.6-fpm-wordpress"
cd 5.6/fpm/wordpress
./build.sh
cd ../../..
docker tag -f caleb/php:5.6-fpm-wordpress caleb/php:latest-fpm-wordpress
