#!/bin/bash

install_fbsd_packages() {
    echo -e "Installing required packages..."
    sudo pkg update
    sudo pkg install -y vala xfce4-appmenu-plugin-0.7.6 catfish plank zenity python3
}

install_gtk_themes() {
    echo -e "Installing Gtk+ themes..."
    sudo cp -R Gtk/California /usr/local/share/themes/
    sudo chown -R root /usr/local/share/themes/California
}

install_icon_themes() {
    echo -e "Installing cursor and icon themes..."
    sudo cp -R icons/Cocoa /usr/local/share/icons/
    sudo cp -R icons/Rainbow /usr/local/share/icons/
    sudo chown -R root /usr/local/share/icons/Cocoa
    sudo chown -R root /usr/local/share/icons/Rainbow
    sudo gtk-update-icon-cache -f /usr/local/share/icons/Cocoa
    sudo cp icons/catfish-symbolic.png /usr/local/share/pixmaps/
    sudo cp icons/bsd-logo.png /usr/local/share/icons/
}

install_fonts() {
    echo -e "Installing fonts..."
    sudo cp -R fonts/SF /usr/local/share/fonts/
    sudo chown -R root /usr/local/share/fonts/SF
    fc-cache -f
}

install_wallpaper() {
    sudo cp backgrounds/Catalina.jpg /usr/local/share/backgrounds/
    sudo chmod 644 /usr/local/share/backgrounds/Catalina.jpg
    sudo chown root /usr/local/share/backgrounds/Catalina.jpg
}

install_plank_theme() {
    sudo cp -R plank/California /usr/local/share/plank/themes/
    sudo chmod 755 /usr/local/share/plank/themes/California
    sudo chmod 644 /usr/local/share/plank/themes/California/*.theme
    sudo chown -R root /usr/local/share/plank/themes/California
}

install_menus() {
    # Menu binary
    sudo cp menus/bin/comice-session /usr/bin/
    sudo chmod 755 /usr/bin/comice-session
    sudo chown root /usr/bin/comice-session
    # Menu Items
    sudo cp menus/items/comice-logout.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-logout.desktop
    sudo chown root /usr/local/share/applications/comice-logout.desktop
    sudo cp menus/items/comice-shutdown.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-shutdown.desktop
    sudo chown root /usr/local/share/applications/comice-shutdown.desktop
    sudo cp menus/items/comice-restart.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-restart.desktop
    sudo chown root /usr/local/share/applications/comice-restart.desktop
    sudo cp menus/items/comice-sleep.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-sleep.desktop
    sudo chown root /usr/local/share/applications/comice-sleep.desktop
    sudo cp menus/items/comice-settings.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-settings.desktop
    sudo chown root /usr/local/share/applications/comice-settings.desktop
    sudo cp menus/items/comice-about.desktop /usr/local/share/applications/
    sudo chmod 644 /usr/local/share/applications/comice-about.desktop
    sudo chown root /usr/local/share/applications/comice-about.desktop
    # Menu XDG for XFCE4
    sudo cp -R menus/xdg/comice.menu /usr/local/etc/xdg/menus
    sudo chmod 644 /usr/local/etc/xdg/menus/comice.menu
    sudo chown root /usr/local/etc/xdg/menus/comice.menu
}

install_fbsd_packages
install_gtk_themes
install_icon_themes
install_fonts
install_wallpaper
install_plank_theme
install_menus
