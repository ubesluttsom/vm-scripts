#!/bin/sh

PORT=1001
WAIT_INTERVAL=1  # Wait interval between checks in seconds

echo "Waiting for port $PORT to be open ..."

# Function to handle SIGINT (Ctrl-C)
cleanup() {
    echo "Interrupted by user, exiting."
    exit 1
}

# Trap SIGINT (Ctrl-C) and call the cleanup function
trap 'cleanup' INT

# Start the timer
start_time=$(date +%s)

# Wait for the port to be open within the time limit
while ! nc -z 127.0.0.1 $PORT; do
    sleep $WAIT_INTERVAL
done

echo "Port $PORT is open, proceeding ..."

qemu-system-aarch64 \
        -m 1024 -cpu cortex-a72 -M virt -nographic --no-reboot \
        -kernel ../linux/arch/arm64/boot/Image \
        -append "console=ttyAMA0 root=/dev/vda vm=1" \
        -drive file=../alpine/rootfs.img,format=raw,snapshot=on \
        -netdev user,id=net0 \
        -device e1000,netdev=net0 \
        -netdev socket,id=net1,connect=127.0.0.1:$PORT \
        -device e1000,netdev=net1,mac=00:00:00:00:00:01 \
        -object filter-dump,id=filter1,netdev=net1,file=/tmp/vm1.pcap
