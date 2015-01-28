#!/usr/bin/env bash

# If the user specified a UID for the www-data user, change the uid of that user
if [ -n "${PHP_FPM_UID}" ]; then
    usermod -u $PHP_FPM_UID www-data
fi

exec "$@"
