#!/bin/bash

echo ""
echo "==================================================================================="
echo "                                   DeUbuntunize                                    "
echo "==================================================================================="
echo ""
echo "Removes extra applications from Ubuntu, making you have a cleaner Linux experience."
echo ""
read -p "Press Enter to continue: "
echo ""

sudo -v && echo "" || exit 1
echo -n "Updating packages information..."
sudo apt update > /dev/null 2>&1

sudo -v && echo "" || exit 1
echo -n "Removing Snap package..."
sudo apt purge snapd -y > /dev/null 2>&1

sudo -v && echo "" || exit 1
echo -n "Removing Software Updates package..."
sudo apt purge software-properties-gtk update-manager -y > /dev/null 2>&1

sudo -v && echo "" || exit 1
echo -n "Removing Ubuntu extensions..."
sudo apt purge gnome-shell-extension-appindicator gnome-shell-extension-desktop-icons gnome-shell-extension-ubuntu-dock -y > /dev/null 2>&1

if [ dpkg -s gnome-session > /dev/null 2>&1 ]; then
    sudo -v && echo "" || exit 1
    echo -n "Removing Ubuntu Session..."
    sudo apt purge ubuntu-session -y > /dev/null 2>&1

    sudo -v && echo "" || exit 1
    echo -n "Removing Yaru theme..."
    sudo apt purge yaru-theme-gnome-shell yaru-theme-gtk yaru-theme-icon yaru-theme-sound -y > /dev/null 2>&1
fi

sudo -v && echo "" || exit 1
echo -n "Removing Ubuntu logo from login screen..."
sudo rm /usr/share/plymouth/ubuntu-logo.png > /dev/null 2>&1

sudo -v && echo "" || exit 1
echo -n "Removing Ubuntu logo from splash screen..."
sudo rm /usr/share/plymouth/themes/spinner/watermark.png > /dev/null 2>&1

echo -n "Hiding Language Selector app..."
rm ~/.local/share/applications/gnome-language-selector.desktop > /dev/null 2>&1
cp /usr/share/applications/gnome-language-selector.desktop ~/.local/share/applications/
sed -i "/Name=/a NoDisplay=true" ~/.local/share/applications/gnome-language-selector.desktop
echo ""

echo -n "Hiding Startup Applications app..."
rm ~/.local/share/applications/gnome-session-properties.desktop > /dev/null 2>&1
cp /usr/share/applications/gnome-session-properties.desktop ~/.local/share/applications/
sed -i "/Name=/a NoDisplay=true" ~/.local/share/applications/gnome-session-properties.desktop
echo ""

if [ -f "/usr/share/applications/gnome-language-selector.desktop" ]; then
    echo -n "Hiding TeXInfo App..."
    rm ~/.local/share/applications/info.desktop > /dev/null 2>&1
    cp /usr/share/applications/info.desktop ~/.local/share/applications/
    sed -i "/Name=/a NoDisplay=true" ~/.local/share/applications/info.desktop
fi
 
sudo -v && echo "" || exit 1
echo -n "Updating system with new settings..."
sudo update-initramfs -u > /dev/null 2>&1

sudo -v && echo "" || exit 1
echo -n "Removing unnecessary packages..."
sudo apt autoremove --purge -y > /dev/null 2>&1

echo ""
echo ""
echo "All ready!"
echo "----------------------------------------------------------------------------------"
echo "Restart the system to enjoy an deubuntunized experience."
echo ""
