#!/bin/bash
## Creative Suite for BSD-XFCE
## Version 1.0

test $? -eq 0 || exit 1 "NEED TO BE ROOT TO RUN THIS (YOU CAN USE SUDO TOO)"

## UPDATE PACKAGES AND PORTS
pkg update && portsnap fetch auto

## COMPILE AND INSTALLS CREATIVE SUITE APPLICATIONS
pkg install -y gimp shotcut eq10q-lv2 drumkv1-lv2 avldrums-lv2 dragonfly-reverb artyfx-lv2 fatfrog-lv2 invada-studio-plugins-lv2 ardour lmms audacity guitarix-lv2 drumgizmo yoshimi hydrogen
echo ""
echo "Creative Suite installed, let's make something good!"
