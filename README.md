# [LibreTime](https://libretime.org/) Docker Image with [s3fs](https://github.com/s3fs-fuse/s3fs-fuse)
![Docker Image CI](https://github.com/LYL-Radio/libretime-s3fs-docker/workflows/Docker%20Image%20CI/badge.svg)

A simple LibreTime with [s3fs]() image for multi-container environment expecting Postgres, Rabbitmq, and Icecast to be set up externally.

You will be required to go through the LibreTime setup wizard when running for the first time, it is strongly recommended to mount `/etc/airtime` folder to persistent volumes to store your configuration.
By default, the S3 bucket will be mounted to `/srv/airtime/stor` to store your media library.

|Environment Variable|Description|Default|
|---|---|---|
|AWS_ACCESS_KEY_ID|(required)||
|AWS_SECRET_ACCESS_KEY|(required)||
|AWS_STORAGE_BUCKET_NAME|(required)||
|AWS_S3_AUTHFILE|Path to s3fs auth file||
|AWS_S3_MOUNTPOINT|Mountpoint|`/srv/airtime/stor`|
|AWS_S3_URL|S3 endpoint|https://s3.amazonaws.com|
|S3FS_ARGS|Additional s3fs mount arguments||
|DEBUG|Enable DEBUG mode|false|


## Install

```bash
docker pull ghcr.io/lyl-radio/libretime-s3fs:latest
```

This repo also provides a `docker-compose.yml` configuration for a quick setup.

## Credits

This image is based on work from:
- [ panubo/docker-s3fs](https://github.com/panubo/docker-s3fs)
