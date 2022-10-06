#!/bin/bash

USER_HOME=$(getent passwd "$USER" | cut -d: -f1)

# Make sure that the apps that make up the interface are not running

pkill xfce4-panel

# Remove old Configurations
rm -Rf /home/$USER_HOME/.gtkrc-2.0
rm -Rf /home/$USER_HOME/.config/gtk-3.0/gtk.css
rm -Rf /home/$USER_HOME/.config/xfce4/panel
rm -Rf /home/$USER_HOME/.config/xfce4/xfconf
rm -Rf /home/$USER_HOME/.config/plank/dock1/*
mkdir -p /home/$USER_HOME/.config/plank/dock1/

# Apply new settings
touch /home/$USER_HOME/.config/gtk-3.0/gtk.css
echo "#xfce4-power-manager-plugin * { -gtk-icon-transform: scale(1.2); }" >> /home/$USER_HOME/.config/gtk-3.0/gtk.css

cd ..

cp -R resources/plank/dock1/launchers /home/$USER_HOME/.config/plank/dock1/
chmod 755 /home/$USER_HOME/.config/plank/dock1/launchers
chmod 644 /home/$USER_HOME/.config/plank/dock1/launchers/*.dockitem
chown -R $USER_HOME /home/$USER_HOME/.config/plank/dock1/
cp -R configurations/xfce4/panel /home/$USER_HOME/.config/xfce4
cp -R configurations/xfce4/xfconf /home/$USER_HOME/.config/xfce4
cp -R configurations/xfce4/autostart /home/$USER_HOME/.config/xfce4
find /home/$USER_HOME/.config/xfce4/panel -type d -exec chmod 755 {} \;
find /home/$USER_HOME/.config/xfce4/panel -type f -exec chmod 644 {} \;
find /home/$USER_HOME/.config/xfce4/xfconf -type d -exec chmod 755 {} \;
find /home/$USER_HOME/.config/xfce4/xfconf -type f -exec chmod 644 {} \;
find /home/$USER_HOME/.config/xfce4/autostart -type d -exec chmod 755 {} \;
find /home/$USER_HOME/.config/xfce4/autostart -type f -exec chmod 644 {} \;
chown -R $USER_HOME /home/$USER_HOME/.config/xfce4/panel
chown -R $USER_HOME /home/$USER_HOME/.config/xfce4/xfconf
chown -R $USER_HOME /home/$USER_HOME/.config/xfce4/autostart

mkdir /home/$USER_HOME/.config/gtk-3.0/
touch /home/$USER_HOME/.config/gtk-3.0/bookmarks
echo "file:///usr/local/share/applications Applications" >> /home/$USER_HOME/.config/gtk-3.0/bookmarks

xfconf-query -c xsettings -p /Gtk/ShellShowsMenubar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/Modules -n -t string -s "appmenu-gtk-module"

xfconf-query -c xfwm4 -p /general/theme -s California
xfconf-query -c xsettings -p /Net/ThemeName -s California
xfconf-query -c xfwm4 -p /general/title_alignment -s center
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
xfconf-query -c xsettings -p /Net/IconThemeName -s Cocoa
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Rainbow
xfconf-query -c xfwm4 -p /general/title_font -s "SF Pro Display 11"
xfconf-query -c xsettings -p /Gtk/FontName -s "SF Pro Display 11"
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s /usr/local/share/backgrounds/Catalina.jpg
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme California
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ dock-items "['Thunar.dockitem', 'org.gnome.gedit.dockitem', 'xfce-settings-manager.dockitem']"
