#!/bin/bash

## COMPILE AND INSTALL LATEST NVIDIA DRIVERS FOR MODERN CARDS (GTX 1*** / RTX Series)
## Please, change /usr/ports/x11/nvidia-driver to /usr/ports/x11/nvidia-driver-470 or nvidia-driver-390 if you use GeForce GT or Titan series card.
## If you're using a legacy Nvidia GeForce card please use nvidia-driver-304 instead

echo "Compiling Nvidia drivers..."
echo ""
#cd /usr/ports/x11/nvidia-driver
#make install clean BATCH=yes
#cd /usr/ports/x11/nvidia-settings
#make install clean BATCH=yes
#cd /usr/ports/x11/nvidia-xconfig
#make install clean BATCH=yes
#nvidia-xconfig
echo ""
echo "Nvidia drivers compiled"
echo ""

## KERNEL MODULE
## For versions prior to 358.09:

# sysrc -f /etc/rc.conf kld_list+=nvidia

## For superior versions:

#sysrc -f /etc/rc.conf kld_list+=nvidia-modeset
