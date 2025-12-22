#!/bin/bash
set -e

source env/target.env
source env/flags.env

cd /tmp
rm -rf gcc-13.2.0
rm -f gcc-13.2.0.tar.xz

wget https://mirrors.dotsrc.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz
tar xf gcc-13.2.0.tar.xz
cd gcc-13.2.0

./contrib/download_prerequisites

rm -rf build
mkdir build
cd build

../configure \
  --target=${TARGET} \
  --prefix=/opt/cross \
  --with-sysroot=${SYSROOT} \
  --disable-nls \
  --disable-shared \
  --disable-multilib \
  --disable-threads \
  --disable-libatomic \
  --disable-libgomp \
  --disable-libquadmath \
  --disable-libssp \
  --disable-libvtv \
  --disable-libstdcxx \
  --enable-languages=c

make -j1 all-gcc
make install-gcc
