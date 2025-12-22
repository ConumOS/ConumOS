#!/bin/bash
set -e

source env/target.env
source env/flags.env

cd /tmp

KERNEL_VERSION=6.10

rm -rf linux-${KERNEL_VERSION}
rm -f  linux-${KERNEL_VERSION}.tar.xz

wget -nc https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz
tar xf linux-${KERNEL_VERSION}.tar.xz
cd linux-${KERNEL_VERSION}

make mrproper

make headers_install \
  ARCH=$(echo $TARGET | cut -d- -f1) \
  INSTALL_HDR_PATH=$SYSROOT/usr
