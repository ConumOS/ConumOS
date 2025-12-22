#!/bin/bash
set -e
source env/target.env
source env/flags.env

cd /tmp/linux-6.10

make defconfig
make
make modules_install INSTALL_MOD_PATH=$SYSROOT
make INSTALL_PATH=$SYSROOT/boot install
