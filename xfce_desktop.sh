#!/bin/bash
#xfce_desktop by Wamphyre (Somekind of FreeBSD Studio and Workstation)
#Version 2.5

test $? -eq 0 || exit 1 "NEED TO BE ROOT TO RUN THIS"

echo "Welcome to BSD-XFCE base script"
echo "This will install a complete, secure and optimized XFCE desktop in your FreeBSD system"
echo "WARNING!! - Execute only in a fresh vanilla installation"
sleep 5

## CHANGE FreeBSD REPOS TO LATEST
LOCAL_REPO_CONFIG_FILE="/usr/local/etc/pkg/repos/FreeBSD.conf"
mkdir -p $(dirname $LOCAL_REPO_CONFIG_FILE)
latest_url=$( sed -n 's/quarterly",/latest"/p' /etc/pkg/FreeBSD.conf )
echo "FreeBSD: { $latest_url }" >$LOCAL_REPO_CONFIG_FILE

## REBUILD AND UPDATE PKG DATABASE 
echo "Upgrading packages..."
echo ""
pkg update && pkg upgrade -y
echo ""

## FETCH FreeBSD PORTS
echo "Downloading Ports tree...";
echo ""
portsnap fetch auto
echo ""

## COMPILE CPU OPTIMIZED APPLICATIONS
touch /etc/make.conf
CPUCORES=$(sysctl hw.ncpu | cut -d ":" -f2 | cut -d " " -f2)
echo "CPUTYPE?=native" >> /etc/make.conf
echo "MAKE_JOBS_NUMBER?=$CPUCORES" >> /etc/make.conf
echo "OPTIONS_SET=OPTIMIZED_CFLAGS CPUFLAGS" >> /etc/make.conf

## INSTALLS BASE DESKTOP AND CORE UTILS
echo "Installing desktop..."
echo ""
xargs pkg install -y < system_packages

## ENABLES BASIC SYSTEM SERVICES
echo "Enabling basic services"
sysrc moused_enable="YES"
sysrc dbus_enable="YES"
sysrc slim_enable="YES"
sysrc update_motd="NO"
sysrc dsbmd_enable="YES"
echo ""

## CHANGE SLIM THEME TO FBSD
sed -i '' 's/current_theme       default/current_theme       fbsd/g' /usr/local/etc/slim.conf

## CREATES .xinitrc SCRIPT FOR A REGULAR DESKTOP USER
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

## CONFIGURES AUTOMOUNT FOR THE REGULAR DESKTOP USER
touch /usr/local/etc/automount.conf
echo "USERUMOUNT=YES" >> /usr/local/etc/automount.conf
echo "USER=$user" >> /usr/local/etc/automount.conf
echo "FM='thunar'" >> /usr/local/etc/automount.conf
echo "NICENAMES=YES" >> /usr/local/etc/automount.conf
echo "/media		-media		-nosuid" >> /etc/auto_master
echo "notify 100 {
	match "system" "GEOM";
	match "subsystem" "DEV";
	action "/usr/sbin/automount -c";
};" >> /etc/devd.conf
sysrc autofs_enable="YES"

## SPECIAL PERMISSIONS FOR USB DRIVES AND WEBCAM
echo "perm    /dev/da0        0666" >> /etc/devfs.conf
echo "perm    /dev/da1        0666" >> /etc/devfs.conf
echo "perm    /dev/da2        0666" >> /etc/devfs.conf
echo "perm    /dev/da3        0666" >> /etc/devfs.conf
echo "perm    /dev/video0     0666" >> /etc/devfs.conf
echo ""

## ADDS USER TO CORE GROUPS
echo "Adding $user to video/realtime/wheel/operator groups"
pw groupmod video -m $user
pw groupmod audio -m $user
pw groupmod realtime -m $user
pw groupmod wheel -m $user
pw groupmod operator -m $user
pw groupmod network -m $user
pw groupmod webcamd -m $user
echo ""

## ADDS USER TO SUDOERS
echo "Adding $user to sudo"
echo "$user ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers
echo ""

## ENABLES LINUX COMPAT LAYER
echo "Enabling Linux compat layer..."
echo ""
kldload linux.ko
sysrc linux_enable="YES"
echo ""

## FreeBSD SYSTEM TUNING FOR BEST DESKTOP EXPERIENCE
echo "Optimizing system parameters and firewall..."
echo ""
mv /etc/sysctl.conf /etc/sysctl.conf.bk
mv /boot/loader.conf /boot/loader.conf.bk
mv /etc/login.conf /etc/login.conf.bk

mv sysctl.conf /etc/
mv login.conf /etc/
mv devfs.rules /etc/
mv loader.conf /boot/

sysrc devfs_system_ruleset="system"
touch /etc/pf.conf
echo 'block in all' >> /etc/pf.conf
echo 'pass out all keep state' >> /etc/pf.conf

## CONFIGURES MORE CORE SYSTEM SERVICES
echo "Enabling additional system services..."
echo ""
sysrc pf_enable="YES"
sysrc pf_rules="/etc/pf.conf" 
sysrc pflog_enable="YES"
sysrc pflog_logfile="/var/log/pflog"
sysrc ntpd_enable="YES"
sysrc ntpdate_enable="YES"
sysrc powerd_enable="YES"
sysrc powerd_flags="-n hiadaptive -a hiadaptive -b adaptive"
sysrc performance_cx_lowest="C1"
sysrc economy_cx_lowest="Cmax"
sysrc clear_tmp_enable="YES"
sysrc syslogd_enable="NO"
sysrc syslogd_flags="-ss"
sysrc sendmail_enable="NO"
sysrc sendmail_msp_queue_enable="NO"
sysrc sendmail_outbound_enable="NO"
sysrc sendmail_submit_enable="NO"
sysrc dumpdev="NO"
sysrc webcamd_enable="YES"
sysrc jackd_enable="YES"
sysrc jackd_user="$user"
sysrc jackd_rtprio="YES"
## Change JACK /dev/dsp7 by your own interfaces
sysrc jackd_args="-doss -r48000 -p256 -n1 -w16 --capture /dev/dsp7 --playback /dev/dsp7"
echo ""

## UPDATES CPU MICROCODE
echo "Updating CPU microcode..."
echo ""
pkg install -y devcpu-data
sysrc microcode_update_enable="YES"
service microcode_update start
echo ""
echo "Microcode updated"
echo ""

## CLEAN CACHES AND AUTOREMOVES UNNECESARY FILES
echo "Cleaning system..."
echo ""
pkg clean -y
pkg autoremove -y
echo ""

## DONE, PLEASE RESTART
echo "Installation done"
echo "Please, check now /boot/loader.conf and /etc/sysctl.conf if you need to make some changes"
echo "Also READ and EDIT the nVidia / Intel / AMD to install the GPU drivers in this step"
echo "Don't forget to reboot your system after that"
echo "BSD-XFCE by Wamphyre :)"
