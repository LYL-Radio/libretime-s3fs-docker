# [LibreTime](https://libretime.org/) Docker Image with [s3fs](https://github.com/s3fs-fuse/s3fs-fuse)
![Docker Image CI](https://github.com/LYL-Radio/libretime-s3fs-docker/workflows/Docker%20Image%20CI/badge.svg)

A simple LibreTime with [s3fs](https://github.com/s3fs-fuse/s3fs-fuse) base on [LYL-Radio/libretime-docker](https://github.com/LYL-Radio/libretime-docker).
## Install

```bash
docker pull ghcr.io/lyl-radio/libretime-s3fs:latest
```

This repo also provides a `docker-compose.yml` configuration for a quick setup.

If you already have an initialized Database, you can directly mount the volume `/etc/airtime/airtime.conf` with your configuration. If you are running LibreTime for the first time with a fresh Database, you will be required to go through the LibreTime setup wizard. It is strongly recommended to mount `/etc/airtime` to save the generated configuration file.

By default, the S3 bucket will be mounted to `/srv/airtime/stor` to store your media library.
### Variables

|Environment Variable|Description|Default|
|---|---|---|
|S3_ACCESS_KEY_ID|(required)||
|S3_SECRET_ACCESS_KEY|(required)||
|S3_BUCKET|(required)||
|S3_CREDENTIALS_FILE|Path to s3fs auth file||
|S3_MOUNTPOINT|Mountpoint|`/srv/airtime/stor`|
|S3_URL|S3 endpoint|https://s3.amazonaws.com|
|S3FS_ARGS|Additional s3fs mount arguments||
|DEBUG|Enable DEBUG mode|false|

## Credits

This image is based on work from:
- [LYL-Radio/libretime-docker](https://github.com/LYL-Radio/libretime-docker)
- [panubo/docker-s3fs](https://github.com/panubo/docker-s3fs)
