.PHONY: all toolchain system kernel boot clean \
        clean-toolchain clean-system clean-kernel clean-boot \
        clean-tmp clean-cross clean-sysroot

all: toolchain system kernel boot

toolchain:
	bash scripts/00-toolchain/binutils.sh
	bash scripts/00-toolchain/linux-headers.sh
	bash scripts/00-toolchain/gcc-pass1.sh
	bash scripts/00-toolchain/musl.sh
	bash scripts/00-toolchain/gcc-pass2.sh

system:
	bash scripts/01-system/busybox.sh
	bash scripts/01-system/init.sh

kernel:
	bash scripts/02-kernel/build.sh

boot:
	bash scripts/03-boot/install.sh

# ======================
# CLEAN TARGETS
# ======================

# limpa TUDO que pode ter dado errado
clean: clean-toolchain clean-system clean-kernel clean-boot clean-tmp

# ---- toolchain ----
clean-toolchain: clean-cross clean-sysroot
	rm -rf /tmp/binutils-*
	rm -rf /tmp/gcc-*
	rm -rf /tmp/musl-*
	rm -rf /tmp/linux-*

# remove toolchain cross
clean-cross:
	rm -rf /opt/cross/*

# remove sysroot (libc, headers, etc)
clean-sysroot:
	rm -rf /opt/sysroot/*

# ---- system ----
clean-system:
	rm -rf /opt/sysroot/bin/*
	rm -rf /opt/sysroot/sbin/*
	rm -rf /opt/sysroot/usr/bin/*
	rm -rf /opt/sysroot/usr/sbin/*

# ---- kernel ----
clean-kernel:
	rm -rf /tmp/linux-*
	rm -rf /opt/sysroot/boot/*

# ---- bootloader ----
clean-boot:
	rm -rf /opt/sysroot/efi
	rm -rf /opt/sysroot/boot/efi

# ---- tmp geral ----
clean-tmp:
	rm -rf /tmp/build-*
	rm -rf /tmp/*.tar.*
