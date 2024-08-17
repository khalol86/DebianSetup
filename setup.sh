#!/bin/bash

# Check if lsb_release is installed
if ! command -v lsb_release &> /dev/null; then
    echo "lsb_release not found, installing it..."
    apt install -y lsb-release
fi

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
    gimp \
    vlc \
    gnome-screenshot \
    network-manager \
    synaptic

# Install Firefox
echo "Installing Firefox..."
apt install -y firefox-esr  # Firefox ESR may be the default for Debian

# Install Steam
echo "Installing Steam..."
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
