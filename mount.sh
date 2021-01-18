#!/bin/bash

set -e
[ "${DEBUG:-false}" == 'true' ] && { set -x; S3FS_DEBUG='-d -d'; }

# Defaults
: ${S3_CREDENTIALS_FILE:='/root/.s3fs'}
: ${S3_MOUNTPOINT:='/srv/airtime/stor'}
: ${S3_URL:='https://s3.amazonaws.com'}
: ${S3FS_ARGS:=''}

# If no command specified, print error
[ "$1" == "" ] && set -- "$@" bash -c 'echo "Error: Please specify a command to run."; exit 128'

# Configuration checks
if [ -z "$S3_BUCKET" ]; then
    echo "Error: S3_BUCKET is not specified"
    exit 128
fi

if [ ! -f "${S3_CREDENTIALS_FILE}" ] && [ -z "$S3_ACCESS_KEY_ID" ]; then
    echo "Error: S3_ACCESS_KEY_ID not specified, or ${S3_CREDENTIALS_FILE} not provided"
    exit 128
fi

if [ ! -f "${S3_CREDENTIALS_FILE}" ] && [ -z "$S3_SECRET_ACCESS_KEY" ]; then
    echo "Error: S3_SECRET_ACCESS_KEY not specified, or ${S3_CREDENTIALS_FILE} not provided"
    exit 128
fi

# Write auth file if it does not exist
if [ ! -f "${S3_CREDENTIALS_FILE}" ]; then
   echo "${S3_ACCESS_KEY_ID}:${S3_SECRET_ACCESS_KEY}" > ${S3_CREDENTIALS_FILE}
   chmod 400 ${S3_CREDENTIALS_FILE}
fi

echo "Mount S3 bucket to ${S3_MOUNTPOINT}"
mkdir -p ${S3_MOUNTPOINT}

# s3fs mount command
s3fs \
  $S3FS_DEBUG \
  -o passwd_file=${S3_CREDENTIALS_FILE} \
  -o url=${S3_URL} \
  -o umask=113 \
  -o mp_umask=113 \
  -o uid=`id -u 'www-data'` \
  -o gid=`id -g 'www-data'` \
  -o allow_other \
  $S3FS_ARGS \
  ${S3_BUCKET} \
  ${S3_MOUNTPOINT}

exec "$@"