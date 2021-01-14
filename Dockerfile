FROM ghcr.io/lyl-radio/libretime:latest

LABEL maintainer "me@maxep.me"
LABEL description "Libretime Radio Broadcast Docker Image with s3fs"
LABEL org.opencontainers.image.source https://github.com/LYL-Radio/libretime-s3fs-docker

RUN apt-get install -y s3fs

RUN s3fs --version

COPY mount.sh /mount.sh

ENTRYPOINT [ "/entrypoint.sh", "/mount.sh", "/usr/bin/systemctl" ]