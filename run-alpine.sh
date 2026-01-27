#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
set -e
systemctl start docker
sleep 5
echo
cat /proc/cpuinfo
echo
if [ "$(cat /proc/cpuinfo | grep -i '^processor' | wc -l)" -gt 1 ]; then
    docker run --cpus="$(cat /proc/cpuinfo | grep -i '^processor' | wc -l).0" --rm --name alpi -itd alpine:3.23
else
    docker run --rm --name alpi -itd alpine:3.23
fi
sleep 2
docker exec alpi apk add --no-cache bash git wget vim curl openssl ca-certificates build-base
docker exec alpi /bin/ln -svf bash /bin/sh
docker exec alpi /bin/bash -c '/bin/rm -fr /tmp/*'
docker cp build.sh alpi:/home/build.sh
docker exec alpi /bin/bash /home/build.sh
docker cp alpi:/tmp/_out /tmp/
exit
