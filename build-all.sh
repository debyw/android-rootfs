#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"

export IMG="debian:buster-slim"
rm -rf 'dist'


# Build amd64, i386, arm64, armhf
./build-from-docker.sh amd64/$IMG debian_amd64
PROOT_ARGS="-q qemu-i386-static" ./build-from-docker.sh i386/$IMG debian_i386
PROOT_ARGS="-q qemu-aarch64-static" ./build-from-docker.sh arm64v8/$IMG debian_arm64
PROOT_ARGS="-q qemu-arm-static" ./build-from-docker.sh arm32v7/$IMG debian_armhf

./generate-md5.sh