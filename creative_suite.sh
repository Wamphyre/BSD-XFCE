#!/bin/bash
## Creative Suite for BSD-XFCE
## Version 1.0

test $? -eq 0 || exit 1 "NEED TO BE ROOT TO RUN THIS (YOU CAN USE SUDO TOO)"

## UPDATE PACKAGES AND PORTS
pkg update && portsnap fetch auto

## COMPILE AND INSTALLS CREATIVE SUITE APPLICATIONS
pkg install -y gimp shotcut eq10q-lv2 avldrums-lv2 lsp-plugins-lv2 ardour6 audacity guitarix-lv2 drumgizmo yoshimi hydrogen
cd /usr/ports/audio/lmms && make install clean OPTIONS="WITH_JACK" BATCH=YES
echo ""

echo "Creative Suite installed, let's make something good!"
