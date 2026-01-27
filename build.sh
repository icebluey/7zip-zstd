#!/bin/bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022

set -euo pipefail

_tmp_dir="$(mktemp -d)"
cd "${_tmp_dir}"

git clone https://github.com/mcmilk/7-Zip-zstd.git

cd 7-Zip-zstd/CPP/7zip/Bundles/Alone2
make -j$(nproc) -f makefile.gcc CC="gcc" CXX="g++" LDFLAGS="-static -no-pie" IS_X64=1

/bin/ls -la _o/
rm -fr /tmp/_out
mkdir /tmp/_out
cp -f _o/7zz /tmp/_out/7z
sleep 1
chmod 0755 /tmp/_out/7z

file _o/7zz
ldd _o/7zz || true
./_o/7zz --version 2>&1 | sed 's/ ([^)]*)//g; s/ /-/g' > /tmp/_out/version.txt
cat /tmp/_out/version.txt

cd /tmp/_out
openssl dgst -r -sha256 7z > 7z.sha256

cd /tmp
rm -fr "${_tmp_dir}"
echo
echo ' done'
echo
exit
