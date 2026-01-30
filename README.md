# 7zip-zstd
build static [7-Zip-zstd](https://github.com/mcmilk/7-Zip-zstd) binary in Alpine.

[![build](https://github.com/icebluey/7zip-zstd/actions/workflows/ci.yml/badge.svg)](https://github.com/icebluey/7zip-zstd/actions/workflows/ci.yml)

Permanent link to latest release data.

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/icebluey/7zip-zstd?style=flat)](https://github.com/icebluey/7zip-zstd/releases)

` 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z.tar' `

```
_install_7z() {
    set -euo pipefail
    local _tmp_dir="$(mktemp -d)"
    cd "${_tmp_dir}"
    #_7zip_loc="$(wget -qO- 'https://www.7-zip.org/download.html' | grep -i '\-linux-x64.tar' | grep -i 'href="' | sed 's|"|\n|g' | grep -i '\-linux-x64.tar' | sort -V | tail -n 1)"
    #wget -q -c -t 9 -T 9 "https://www.7-zip.org/${_7zip_loc}"
    #tar -xof *.tar*
    #sleep 1
    #rm -f *.tar*
    #file 7zzs | sed -n -E 's/^(.*):[[:space:]]*ELF.*, not stripped.*/\1/p' | xargs --no-run-if-empty -I '{}' strip '{}'
    #rm -f 7z && mv 7zzs 7z
    wget -q -c -t 9 -T 9 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z.tar'
    wget -q -c -t 9 -T 9 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z.tar.sha256'
    sha256sum -c 7z.tar.sha256
    tar -xof 7z.tar
    rm -f /usr/bin/7z /usr/local/bin/7z
    install -v -c -m 0755 7z /usr/bin/7z
    cp -f /usr/bin/7z /usr/local/bin/7z
    /usr/bin/7z --version 2>/dev/null || true
    cd /tmp
    rm -fr "${_tmp_dir}"
}
_install_7z
```
