FROM ghcr.io/lyl-radio/libretime:3.0.0-alpha.9

LABEL maintainer "me@maxep.me"
LABEL description "Libretime Radio Broadcast Docker Image with s3fs"
LABEL org.opencontainers.image.source https://github.com/LYL-Radio/libretime-s3fs-docker

RUN apt-get install -y s3fs

COPY mount.sh /mount.sh

ENTRYPOINT [ "/entrypoint.sh", "/mount.sh", "/usr/bin/systemctl" ]