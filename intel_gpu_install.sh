#!/bin/bash

pkg install -y drm-kmod libva-intel-driver
sysrc -f /etc/rc.conf kld_list+=i915kms

echo ""

echo "Intel Graphics installed and configured, restart your system"
