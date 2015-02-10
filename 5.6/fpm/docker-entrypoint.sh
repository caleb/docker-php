#!/usr/bin/env bash
set -e
shopt -s globstar

export PHP_FPM_PORT
export PHP_FPM_MAX_CHILDREN
export PHP_FPM_START_SERVERS
export PHP_FPM_MIN_SPARE_SERVERS
export PHP_FPM_MAX_SPARE_SERVERS
export PHP_FPM_UPLOAD_MAX_FILESIZE
export PHP_FPM_POST_MAX_SIZE

: ${PHP_FPM_PORT:=9000}
: ${PHP_FPM_MAX_CHILDREN:=5}
: ${PHP_FPM_START_SERVERS=2}
: ${PHP_FPM_MIN_SPARE_SERVERS:=1}
: ${PHP_FPM_MAX_SPARE_SERVERS:=3}
: ${PHP_FPM_UPLOAD_MAX_FILESIZE:=2M}
: ${PHP_FPM_POST_MAX_SIZE:=8M}

if [ -n "${PHP_FPM_SHARED_LINK}" ]; then
  PHP_FPM_SHARED_LINK_DEFAULT="${PHP_FPM_SHARED_LINK}"
fi

# Link shared directories (like uploads)
for link_var in ${!PHP_FPM_SHARED_LINK_*}; do
  link="${!link_var}"
  if [ -n "${link}" ]; then
    from="${link%%:*}"
    to="${link#*:}"
    if [ -z "${from}" ] || [ -z "${to}" ]; then
      echo "A link must be in the form <from>:<to>"
      exit 1
    else
      ln -f -s -T "${from}" "${to}"
    fi
  fi
done

# Fill out the templates
for f in /usr/local/etc/**/*.mo; do
  /usr/local/bin/mo "${f}" > "${f%.mo}"
  rm "${f}"
done

exec "$@"
