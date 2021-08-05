
#!/bin/bash
#
# Examples:
#   PROO
#
cd "$(dirname "${BASH_SOURCE[0]}")"


# Configuration
export DEBYW_REPOS=${DEBYW_REPOS:-'
deb [trusted=yes] https://debyw.github.io/repo-main dist/
'}

export DEBYW_PACKAGES=${DEBYW_PACKAGES:-'x11vnc xterm xvfb bspwm inotify-tools psmisc xdotool debyw-app-xterm'}


# Clean from previous builds
rm -rf ".tmp"
mkdir -p ".tmp/rootfs"
mkdir -p "dist"


# 

echo "BUILDING $2
--> cloning from docker"

docker pull $1
ID=$(docker create $1 /bin/bash -l)
docker export -o ".tmp/rootfs.tar" "$ID"
docker container rm "$ID"

cd ".tmp/rootfs"
tar -xf "../rootfs.tar"
rm -f ".dockerenv"



echo '
--> installing repos and packages'

proot $PROOT_ARGS -S . /bin/bash -c 'apt-get update &&
DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends apt-transport-https ca-certificates'

echo "$DEBYW_REPOS" >> ./etc/apt/sources.list

proot $PROOT_ARGS -S . /bin/bash -c 'apt-get update && 
DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends '"$DEBYW_PACKAGES" 



echo '
--> Creating archive'

cd ../
rm -f "../dist/$2.tar"
tar -cf "../dist/$2.tar" rootfs
rm -f "../dist/$2.tar.xz"
xz "../dist/$2.tar"


echo 'Done!
'