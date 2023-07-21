#!/bin/bash

## Two modules exist for AMD hardware:
# - amdgpu
# - radeonkms
# - Choose one, based on the generation of the hardware.

## The amdgpu module is for post-HD7000 or Tahiti GPUs.

#pkg install -y drm-kmod
#sysrc -f /etc/rc.conf kld_list+=amdgpu

## The radeonkms module is for older GPUs (pre-HD7000 or pre-Tahiti).

#pkg install -y drm-kmod
#sysrc -f /etc/rc.conf kld_list+=radeonkms

echo ""

echo "AMD Graphics installed and configured, restart your system"