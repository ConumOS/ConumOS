#!/bin/bash
set -e
source env/target.env

mkdir -pv $SYSROOT/{proc,sys,dev,etc}

cat > $SYSROOT/init << "EOF"
#!/bin/sh
mount -t proc proc /proc
mount -t sysfs sys /sys
mount -t devtmpfs dev /dev
echo "distro-linux boot OK"
exec /bin/sh
EOF

chmod +x $SYSROOT/init
