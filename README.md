# VM scripts

Scripts for running testing VMs using QEMU. Depends on both a
`../alpine/rootfs.img` and a kernel `../linux/arch/arm64/boot/Image` being
present. Note the relative paths.

### Topology

```
┌──────┐   ┌───────────┐   ┌──────┐
│ VM 1 o───o Router VM o───o VM 2 │
└──────┘   └───────────┘   └──────┘
```

### The scripts

* `vm-router.sh` starts the router.
* `vm{1,2}.sh` starts the nodes.
* `tmux.sh` starts all the VMs in a `tmux` session.
* `vm-snapshot-off.sh` starts a VM with the same rootfs as the VMs, but with
  snapshot mode off, meaning changes are persistent.
