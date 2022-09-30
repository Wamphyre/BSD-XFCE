#!/bin/bash

if [ $EUID -ne 0 ]; then
	echo ERROR: You must run this as root
	exit
fi

plymouthd
plymouth --show-splash
sleep ${1:-2}
plymouth quit
