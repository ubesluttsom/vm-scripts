#!/bin/sh
qemu-system-aarch64 \
        -m 1024 -cpu cortex-a72 -M virt -nographic --no-reboot \
        -kernel ../linux/arch/arm64/boot/Image \
        -append "console=ttyAMA0 root=/dev/vda vm=router" \
        -drive file=../alpine/rootfs.img,format=raw,snapshot=on \
        -netdev user,id=net0 \
        -device e1000,netdev=net0 \
        -netdev socket,id=net1,listen=:1001 \
        -device e1000,netdev=net1,mac=00:00:00:00:01:00 \
        -netdev socket,id=net2,listen=:1002 \
        -device e1000,netdev=net2,mac=00:00:00:00:02:00 \
        -object filter-dump,id=filter1,netdev=net1,file=/tmp/vm-router1.pcap \
        -object filter-dump,id=filter2,netdev=net2,file=/tmp/vm-router2.pcap
