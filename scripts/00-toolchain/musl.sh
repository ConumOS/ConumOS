#!/bin/bash
set -e

# =========================
# Ambiente
# =========================
source env/target.env
source env/flags.env

export CC="${TARGET}-gcc"
export AR="${TARGET}-ar"
export RANLIB="${TARGET}-ranlib"

export SYSROOT="/opt/sysroot"

export CFLAGS="--sysroot=${SYSROOT} -O2 -pipe"
export LDFLAGS="--sysroot=${SYSROOT} -lgcc"

# =========================
# Download
# =========================
cd /tmp
rm -rf musl-1.2.5
rm -f  musl-1.2.5.tar.gz

wget https://musl.libc.org/releases/musl-1.2.5.tar.gz
tar xf musl-1.2.5.tar.gz
cd musl-1.2.5

# =========================
# Configure
# =========================
./configure \
  --prefix=/usr \
  --syslibdir=/lib \
  --host=${TARGET} \
  --build=$(./scripts/config.guess)

# =========================
# Build
# =========================
make -j1

# =========================
# Install no SYSROOT
# =========================
DESTDIR="${SYSROOT}" make install

# =========================
# Symlinks obrigatórios
# =========================
ln -sf ../lib/libc.so "${SYSROOT}/usr/bin/ldd"

echo "[OK] musl instalado com sucesso no sysroot"
