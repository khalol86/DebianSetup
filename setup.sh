#!/bin/bash

# Backup existing sources list
echo "Backing up existing sources list..."
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Update sources list
echo "Updating sources list..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ $(lsb_release -cs) main contrib non-free
deb-src http://deb.debian.org/debian/ $(lsb_release -cs) main contrib non-free

deb http://security.debian.org/ $(lsb_release -cs)-security main contrib non-free
deb-src http://security.debian.org/ $(lsb_release -cs)-security main contrib non-free

deb http://deb.debian.org/debian/ $(lsb_release -cs)-updates main contrib non-free
deb-src http://deb.debian.org/debian/ $(lsb_release -cs)-updates main contrib non-free
EOF

# Optionally add the Mozilla repository for latest Firefox
echo "Adding Mozilla repository for the latest Firefox..."
echo "deb [arch=amd64] https://deb.debian.org/debian/ $(lsb_release -cs) main contrib non-free" >> /etc/apt/sources.list.d/mozilla.list

# Add Steam repository
echo "Adding Steam repository..."
wget -O /usr/share/keyrings/steam.gpg https://repo.steampowered.com/steam/archive/stable/steam.gpg
echo "deb [signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/archive/stable/ steam main" | tee /etc/apt/sources.list.d/steam.list


# Update package list and upgrade installed packages
echo "Updating package list and upgrading installed packages..."
apt update
apt upgrade -y

# Install minimal XFCE desktop environment (without goodies)
echo "Installing minimal XFCE desktop environment..."
apt install -y xfce4

# Install essential applications
echo "Installing essential applications..."     
apt install -y \
    gimp \             # Image editor
    vlc \              # Media player
    gnome-screenshot \ # Screenshot tool
    network-manager \  # Network management tool
    synaptic \         # Package manager

# Install firefox
echo "Installing Firefox..." 
apt install -y firefox


# Install firefox
echo "Installing steam..." 
apt install -y steam


# Clean up the package cache
echo "Cleaning up the package cache..."
apt clean

# Remove unnecessary packages
echo "Removing unnecessary packages..."
apt autoremove -y

# Reboot the system to start the graphical environment
#echo "Rebooting the system..."
#reboot
