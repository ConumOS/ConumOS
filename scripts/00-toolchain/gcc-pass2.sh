#!/bin/bash
set -e
source env/target.env
source env/flags.env

cd /tmp/gcc-14.1.0
cd build

make all
make install
