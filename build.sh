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
echo
echo ' done'
echo
exit
