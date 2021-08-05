#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"


# Generate md5 check codes for every rootfs file.
# Output format is the one of kotlin hashmaps.
echo "i386:   $(md5sum ./dist/debian_i386.tar.xz   |cut -f 1 -d " ")" >  ./dist/md5.txt
echo "amd64:  $(md5sum ./dist/debian_amd64.tar.xz  |cut -f 1 -d " ")" >> ./dist/md5.txt
echo "armhf:  $(md5sum ./dist/debian_armhf.tar.xz  |cut -f 1 -d " ")" >> ./dist/md5.txt
echo "arm64:  $(md5sum ./dist/debian_arm64.tar.xz  |cut -f 1 -d " ")" >> ./dist/md5.txt