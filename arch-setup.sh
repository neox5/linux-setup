#!/bin/bash

# Set variables - Customize these as needed
HOSTNAME="orion"
USERNAME="neox5"
TIMEZONE="Europe/Vienna"
LOCALE="en_US.UTF-8"
KEYMAP="de-latin1"
LANG="en_US.UTF-8"
CHROMIUM_VERSION="121.0.6167.139-1"

# Update the system clock
timedatectl set-ntp true

# Set the timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Generate the locales
sed -i "/^#$LOCALE/s/^#//" /etc/locale.gen
locale-gen
echo "LANG=$LANG" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

# Set the hostname
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Create a new user with sudo privileges
useradd -m -G wheel -s /bin/zsh $USERNAME
# Set the initial password to username
echo"$USERNAME:$USERNAME" | chpasswd

sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

# install desktop packages
pacman -Syu --noconfirm xorg plasma kde-applications sddm
# enable desktop manager
systemctl enable sddm

# install user packages
pacman -Syu --noconfirm zsh neovim git less tree neofetch
# install ungoogled-chromium
PACKAGE_URL="https://github.com/ungoogled-software/ungoogled-chromium-archlinux/releases/download/${CHROMIUM_VERSION}/ungoogled-chromium-${CHROMIUM_VERSION}-x86_64.pkg.tar.zst"
OUTPUT_PATH="/tmp/ungoogled-chromium-${CHROMIUM_VERSION}-x86_64.pkg.tar.zst"
curl -L "$PACKAGE_URL" -o "$OUTPUT_PATH"
pacman -U "$OUTPUT_PATH"

# enable network service
systemctl enable NetworkManager



# Reboot the system
echo "Installation completed. Rebooting in 5 seconds..."
sleep 5
reboot
