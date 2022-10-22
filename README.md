# BSD-XFCE
BSD-XFCE is a collection of scripts and FreeBSD filesystem configurations to install a full-fledged and high-performant XFCE enviroment specially optimized for desktop and workstation use without the hassle and with a very beautiful looking for classic macOS users.

## Screenshots

![App Screenshot](https://github.com/Wamphyre/BSD-XFCE/blob/main/screenshot.png)

## Features

- Installs complete XFCE desktop from latest repo
- Installs Creative Suite (Audio/Video & image editing applications)
- Enables high quality sound server with JACK by default
- Enables automount for many filesystems
- Installs latest NVIDIA graphics drivers (No AMD/Intel support for now)
- Enables Linux compatibility layer (default CentOS 7)
- Enables webcam support by default
- Enables general system performance for desktop use
- PF Firewall and security flags enabled by default
- Updates CPU microcode
- Improves FreeBSD boot times

## Installation (FreeBSD 13/13.*/14)

```
git clone https://github.com/Wamphyre/BSD-XFCE && sh BSD-XFCE/xfce_desktop.sh
```
## Post-installation (macOS skinpack) <- Optional but recommended

```
IMPORTANT! Run these scripts with your user, not root.

Step 1: cd xfce4BSD-macOS_skinpack/resources/ && sudo sh install_resources.sh
Step 2 (As regular user): cd xfce4BSD-macOS_skinpack/configurations/ && sh apply.sh
```
Please, use this scripts only in a fresh FreeBSD installation.

At some point, the script will ask you for username to enable XFCE start exec and other services like automount capabilities.
## Authors

- [@wamphyre](https://github.com/Wamphyre)

## Credits
- All the good guys at FreeBSD forums
- GhostBSD repository
- NomadBSD repository
- libredeb (For the original XFCE macOS skinpack for Linux)
- Vermaden (For automount and well written documentation)
