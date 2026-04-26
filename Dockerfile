FROM alpine:latest
ARG PACKAGE_VERSION

RUN apk update && \
    apk add --no-cache alpine-sdk coreutils sudo gcompat

RUN adduser -D builder && \
    addgroup builder abuild && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builder
COPY --chown=builder:builder . /home/builder/pkg
WORKDIR /home/builder/pkg

RUN --mount=type=secret,id=apk_private_key \
    --mount=type=secret,id=apk_public_key \
    sudo cp /run/secrets/apk_private_key ~/nomad-alpine-apk.rsa && \
    sudo cp /run/secrets/apk_public_key ~/nomad-alpine-apk.rsa.pub && \
    sudo cp /run/secrets/apk_public_key /etc/apk/keys/nomad-alpine-apk.rsa.pub && \
    sudo chown builder:builder ~/nomad-alpine-apk.rsa* && \
    sudo chmod 444 /etc/apk/keys/nomad-alpine-apk.rsa.pub && \
    mkdir -p ~/.abuild && \
    echo "PACKAGER_PRIVKEY=~/nomad-alpine-apk.rsa" > ~/.abuild/abuild.conf && \
    abuild checksum && \
    abuild -d
