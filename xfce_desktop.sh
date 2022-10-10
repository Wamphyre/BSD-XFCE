#!/bin/bash

#xfce_desktop by Wamphyre
#Version 1.0

test $? -eq 0 || exit 1 "NEED TO BE ROOT TO RUN THIS"

echo "Welcome to BSD-XFCE base script"
echo "This will install a complete, secure and optimized XFCE desktop in your FreeBSD system"
echo "WARNING!! - Execute only in a fresh vanilla installation"

sleep 5

sed -i '' 's/quarterly/latest/g' /etc/pkg/FreeBSD.conf

echo "Upgrading packages..."

echo ""

pkg update && pkg upgrade -y

echo ""

echo "Downloading Ports tree...";

echo ""

portsnap fetch auto

echo ""

echo "Installing XFCE and creative suite..."

echo ""

pkg install -y xorg slim xfce xfce4-pulseaudio-plugin thunar-archive-plugin xarchiver unzip sudo bash wget htop gnome-keyring xfce4-screenshooter-plugin ristretto atril-lite gnome-font-viewer mixer mixertui nano baobab networkmgr v4l-utils v4l_compat webcamd pwcview sctd brut clamtk

pkg install -y vlc deadbeef audacity ardour6 guitarix-lv2 hydrogen yoshimi qjackctl firefox krita shotcut filezilla vscode

cd /usr/ports/audio/lsp-plugins-lv2 && make install clean BATCH=YES
cd /usr/ports/audio/lmms && make install clean WITH_JACK WITH_PULSEAUDIO BATCH=YES

echo ""

echo "Enabling automount..."

echo ""

pkg install -y automount exfat-utils fusefs-exfat fusefs-ntfs fusefs-ext2 fusefs-hfsfuse fusefs-lkl fusefs-simple-mtpfs dsbmc

echo ""

echo "Enabling basic services"

sysrc moused_enable="YES"
sysrc dbus_enable="YES"
sysrc hald_enable="YES"
sysrc slim_enable="YES"
sysrc update_motd="NO"
sysrc rc_startmsgs="NO"

echo ""

cd

touch .xinitrc

echo 'exec xfce4-session' >> .xinitrc

echo ""

echo ; read -p "Want to enable XFCE for a regular user? (yes/no): " X;

echo ""

if [ "$X" = "yes" ]
then
    echo ; read -p "For what user? " user;
    touch /usr/home/$user/.xinitrc
    echo 'exec xfce4-session' >> /usr/home/$user/.xinitrc
    echo ""
    echo "$user enabled"
else fi

touch /usr/local/etc/automount.conf
echo "USERUMOUNT=YES" >> /usr/local/etc/automount.conf
echo "USER=$user" >> /usr/local/etc/automount.conf
echo "FM='thunar'" >> /usr/local/etc/automount.conf
echo "NICENAMES=YES" >> /usr/local/etc/automount.conf

echo "perm    /dev/da0        0666" >> /etc/devfs.conf
echo "perm    /dev/da1        0666" >> /etc/devfs.conf
echo "perm    /dev/da2        0666" >> /etc/devfs.conf
echo "perm    /dev/da3        0666" >> /etc/devfs.conf
echo "perm    /dev/video0     0666" >> /etc/devfs.conf

echo ""

echo "Adding $user to video/realtime/wheel/operator groups"
pw usermod $user -G video
pw usermod $user -G realtime
pw usermod $user -G wheel
pw usermod $user -G operator
pw usermod $user -G network
pw usermod $user -G webcamd

echo ""

echo "Adding $user to sudo"
echo "$user ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers

echo ""

echo "Enabling Linux compat layer..."

echo ""

kldload linux.ko
sysrc linux_enable="YES"

echo ""

echo "Compiling latest Nvidia drivers..."

echo ""

cd /usr/ports/x11/nvidia-driver
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-settings
make install clean BATCH=yes
cd /usr/ports/x11/nvidia-xconfig
make install clean BATCH=yes
nvidia-xconfig

echo ""

echo "Latest Nvidia drivers compiled"

echo ""

echo "Optimizing system parameters and firewall..."

echo ""

mv /etc/sysctl.conf /etc/sysctl.conf.bk
mv /boot/loader.conf /boot/loader.conf.bk
mv /etc/login.conf /etc/login.conf.bk
cd /etc/ && fetch https://raw.githubusercontent.com/Wamphyre/BSD-XFCE/main/sysctl.conf
fetch https://raw.githubusercontent.com/Wamphyre/BSD-XFCE/main/login.conf
fetch https://raw.githubusercontent.com/Wamphyre/BSD-XFCE/main/devfs.rules
cd /boot/ && fetch https://raw.githubusercontent.com/Wamphyre/BSD-XFCE/main/loader.conf
sysrc devfs_system_ruleset="desktop"
cd
touch /etc/pf.conf
echo 'block in all' >> /etc/pf.conf
echo 'pass out all keep state' >> /etc/pf.conf

echo "Enabling additional system services..."

echo ""

sysrc pf_enable="YES"
sysrc pf_rules="/etc/pf.conf" 
sysrc pf_flags=""
sysrc pflog_enable="YES"
sysrc pflog_logfile="/var/log/pflog"
sysrc pflog_flags=""
sysrc ntpd_enable="YES"
sysrc ntpdate_enable="YES"
sysrc powerd_enable="YES"
sysrc powerd_flags="-a hiadaptive"
sysrc clear_tmp_enable="YES"
sysrc syslogd_flags="-ss"
sysrc sendmail_enable="NONE"
sysrc sendmail_msp_queue_enable="NO"
sysrc sendmail_outbound_enable="NO"
sysrc sendmail_submit_enable="NO"
sysrc dumpdev="NO"
sysrc webcamd_enable="YES"
sysrc webcamd_0_flags="-d ugen2.2"
sysrc jackd_enable="YES"
sysrc jackd_user="$user"
sysrc jackd_rtprio="YES"
sysrc jackd_args="-r -doss -r48000 -p512 -n1 -w16 \
            --capture /dev/dsp7 --playback /dev/dsp7"

echo ""

echo "Updating CPU microcode..."

echo ""

pkg install -y devcpu-data
sysrc microcode_update_enable="YES"
service microcode_update start

echo ""

echo "Microcode updated"

echo ""

echo "Cleaning system..."

echo ""

pkg clean -y
pkg autoremove -y

echo ""

echo "Installation done"
echo "Please restart your system."
echo "BSD-XFCE by Wamphyre :)"
