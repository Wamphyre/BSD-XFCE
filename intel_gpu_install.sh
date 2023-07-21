#!/bin/bash

## If you notice high CPU usage, or excessive tearing with HD video: multimedia/libva-intel-driver may help – installation should be in addition to drm-kmod, mesa-libs and mesa-dri.

pkg install -y drm-kmod
sysrc -f /etc/rc.conf kld_list+=i915kms

echo ""

echo "Intel Graphics installed and configured, restart your system"