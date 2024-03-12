#!/bin/sh
qemu-system-aarch64 \
        -m 1024 -cpu cortex-a72 -M virt -nographic --no-reboot \
        -kernel ../linux/arch/arm64/boot/Image \
        -append "console=ttyAMA0 root=/dev/vda" \
        -drive file=../alpine-rootfs/rootfs.img,format=raw,snapshot=off
