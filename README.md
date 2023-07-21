# BSD-XFCE
BSD-XFCE is a collection of scripts and FreeBSD filesystem configurations to install a full-fledged and high-performant XFCE enviroment specially optimized for desktop and workstation use without the hassle and with a very beautiful looking for classic OS X users.

## DISCLAIMER: This project doesn't want to be a "OS X clone on FreeBSD" or whatever. The installation of the macOS skinpack is totally optional, the base system installation and configurations are the big deal.

## Screenshots

![App Screenshot](https://github.com/Wamphyre/BSD-XFCE/blob/main/screenshot.png)
![App Screenshot](https://github.com/Wamphyre/BSD-XFCE/blob/main/screenshot2.png)

## Features

- Installs complete XFCE desktop from latest repo
- Installs Creative Suite (Audio/Video & image editing applications)
- Enables high quality sound server with JACK by default
- Enables automount for many filesystems
- Installs latest NVIDIA / INTEL / AMD graphics drivers (Just edit and use the correct installer script)
- Enables Linux compatibility layer (default CentOS 7)
- Enables webcam support by default
- Enables general system performance for desktop use
- PF Firewall and security flags enabled by default
- Updates CPU microcode
- Improves FreeBSD boot times

## Before installation
Read the code before install, you would like to change some parameters (Drivers for your GPU, sound devices, webcams...)

## Installation (FreeBSD 13/13.*/14)

```
git clone https://github.com/Wamphyre/BSD-XFCE && sh BSD-XFCE/xfce_desktop.sh
```
## GPU Drivers <- Step **BEFORE** reboot
```
IMPORTANT! READ and EDIT the scripts before execution

Nvidia drivers use: nvidia_gpu_install.sh
Intel drivers use: intel_gpu_install.sh
AMD drivers use: amd_gpu_install.sh
```
## Post-installation (macOS skinpack) <- Optional step **AFTER** reboot
```
IMPORTANT! Run these scripts with your user, not root.

Step 1: cd xfce4BSD-macOS_skinpack/resources/ && sudo sh install_resources.sh
Step 2 (As regular user): cd xfce4BSD-macOS_skinpack/configurations/ && sh apply.sh
```
## Creative Suite <- Optional step **AFTER** reboot
```
sudo sh creative_suite.sh
```
Please, use this scripts only in a fresh FreeBSD installation.

At some point, the script will ask you for username to enable XFCE start exec and other services like automount capabilities.

## SUPPORT
Please, open an issue if you need help or want to suggest something. I will try my best :)

## Authors

- [@wamphyre](https://github.com/Wamphyre)

## Credits
- [All the good guys at FreeBSD forums](https://forums.freebsd.org/)
- [GhostBSD repository](https://github.com/GhostBSD)
- [NomadBSD repository](https://github.com/nomadbsd/NomadBSD)
- [Goran Mekić (For all the good advices about FreeBSD audio)](https://meka.rs/blog/2021/10/12/freebsd-audio/)
- [libredeb (For the original XFCE macOS skinpack for Linux)](https://github.com/libredeb/xfce4-macOS_skinpack)
- [Vermaden (For automount and well written documentation)](https://github.com/vermaden/automount)
