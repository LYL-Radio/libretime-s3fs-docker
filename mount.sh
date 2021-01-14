#!/bin/bash

set -e
[ "${DEBUG:-false}" == 'true' ] && { set -x; S3FS_DEBUG='-d -d'; }

# Defaults
: ${AWS_S3_AUTHFILE:='/root/.s3fs'}
: ${AWS_S3_MOUNTPOINT:='/srv/airtime/stor'}
: ${AWS_S3_URL:='https://s3.amazonaws.com'}
: ${S3FS_ARGS:=''}

# If no command specified, print error
[ "$1" == "" ] && set -- "$@" bash -c 'echo "Error: Please specify a command to run."; exit 128'

# Configuration checks
if [ -z "$AWS_STORAGE_BUCKET_NAME" ]; then
    echo "Error: AWS_STORAGE_BUCKET_NAME is not specified"
    exit 128
fi

if [ ! -f "${AWS_S3_AUTHFILE}" ] && [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "Error: AWS_ACCESS_KEY_ID not specified, or ${AWS_S3_AUTHFILE} not provided"
    exit 128
fi

if [ ! -f "${AWS_S3_AUTHFILE}" ] && [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "Error: AWS_SECRET_ACCESS_KEY not specified, or ${AWS_S3_AUTHFILE} not provided"
    exit 128
fi

# Write auth file if it does not exist
if [ ! -f "${AWS_S3_AUTHFILE}" ]; then
   echo "${AWS_ACCESS_KEY_ID}:${AWS_SECRET_ACCESS_KEY}" > ${AWS_S3_AUTHFILE}
   chmod 400 ${AWS_S3_AUTHFILE}
fi

echo "Mount S3 bucket to ${AWS_S3_MOUNTPOINT}"
mkdir -p ${AWS_S3_MOUNTPOINT}

# s3fs mount command
s3fs \
  $S3FS_DEBUG \
  -o passwd_file=${AWS_S3_AUTHFILE} \
  -o url=${AWS_S3_URL} \
  -o umask=113 \
  -o mp_umask=113 \
  -o uid=`id -u 'www-data'` \
  -o gid=`id -g 'www-data'` \
  -o allow_other \
  $S3FS_ARGS \
  ${AWS_STORAGE_BUCKET_NAME} \
  ${AWS_S3_MOUNTPOINT}

exec "$@"