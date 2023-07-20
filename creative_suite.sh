#!/bin/bash
## Creative Suite for BSD-XFCE
## Version 1.5

test $? -eq 0 || exit 1 "NEED TO BE ROOT TO RUN THIS (YOU CAN USE SUDO TOO)"

## UPDATE PACKAGES
pkg update 

## INSTALLS CREATIVE SUITE APPLICATIONS (Audio/Video)
xargs pkg install -y < creative_packages
echo ""
echo "Creative Suite installed, let's make something good!"
