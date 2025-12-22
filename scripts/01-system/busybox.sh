#!/bin/bash
set -e
source env/target.env
source env/flags.env

cd /tmp
wget -nc https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar xf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

make defconfig
make
make CONFIG_PREFIX=$SYSROOT install
