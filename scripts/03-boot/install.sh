#!/bin/bash
set -e
source env/target.env

EFI=/boot/efi/EFI/distro-linux
sudo mkdir -p $EFI

sudo cp /mnt/lfs/boot/vmlinuz-* $EFI/BOOTX64.EFI
