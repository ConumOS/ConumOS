#!/bin/bash
set -e

source env/target.env
source env/flags.env

cd /tmp

rm -rf binutils-2.43
rm -f binutils-2.43.tar.xz

wget https://mirror.math.princeton.edu/pub/gnu/binutils/binutils-2.43.tar.xz

tar xf binutils-2.43.tar.xz
cd binutils-2.43

mkdir build
cd build

CFLAGS="-Wno-error=stringop-overread" \
../configure \
  --prefix=/opt/cross \
  --target=$TARGET \
  --with-sysroot=$SYSROOT \
  --disable-nls \
  --disable-werror \
  --disable-gprofng

make -j1
make install
