#!/usr/bin/env bash
set -e
shopt -s globstar

export PHP_FPM_PORT
export PHP_FPM_MAX_CHILDREN
export PHP_FPM_START_SERVERS
export PHP_FPM_MIN_SPARE_SERVERS
export PHP_FPM_MAX_SPARE_SERVERS

: ${PHP_FPM_PORT:=9000}
: ${PHP_FPM_MAX_CHILDREN:=5}
: ${PHP_FPM_START_SERVERS=2}
: ${PHP_FPM_MIN_SPARE_SERVERS:=1}
: ${PHP_FPM_MAX_SPARE_SERVERS=3}

# Fill out the templates
for f in /usr/local/etc/**/*.mo; do
  /usr/local/bin/mo "${f}" > "${f%.mo}"
  rm "${f}"
done

exec "$@"
