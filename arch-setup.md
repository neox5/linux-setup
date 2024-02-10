# Arch Setup
Source: [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)

## 1 Prerequisite

Create usb boot drive
- download iso from a mirror at [Arch Linux Downloads](https://archlinux.org/download)
- insert usb drive
- identify device: `lsblk`
- unmount device: `umount /dev/sdx`
- write iso to device: `sudo dd if=/path/to/your.iso of=/dev/sdX bs=4M status=progress`
- Boot from usb drive.

## 2 Installation

### Disk Partitioning
```bash
# set keyboard layout
$ loadkeys de-latin1

# disk partitioning
# MOUNT_POINT  PARTITION             FORMAT  SIZE 
# /mnt/boot    efi_system_partition  FAT32   1GB
# /mnt         root_partition        EXT4    rest
$ fdisk /dev/disk_to_be_partitioned
# -----------------------------------------------
# efi_system_partition
# 
# add new partition: n
# partition number: 1 (default) 
# First sector: 2048 (default)
# Last sector: +1G (efi_system_partition)
# change partition type: t
# Partition type: 1 (EFI System)
# --------------------
# root_partition
#
# add new partition: n
# partition number: 2 (default)
# First sector: XXXX (default) ... after efi_system_partition
# Second sector: XXXX (default) ... rest of the disk
# --------------------
#
# review partition table: p
#
# write partition table: w

# format partitions
mkfs.ext4 /dev/root_partition
mkfs.fat -F 32 /dev/efi_system_partition

# mount file systems
mount /dev/root_partition /mnt
mount --mkdir /dev/efi_system_partition /mnt/boot
```

### Installation
```bash
# install essentials
pacstrap -K /mnt base base-devel linux linux-firmware grub efibootmgr networkmanager sudo
```

### System Configuration
```bash
# generate fstab file (use -U or -L to define by UUID or labels)
genfstab -U /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt

# change timezone
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/timezone
# generate /etc/adjtime
hwclock --systohc

# localization
# uncomment en_US.UTF-8 UTF-8 in /etc/locale.gen
LOCALE="en_US.UTF-8" sed -i "/^#$LOCALE/s/^#//" /etc/locale.gen
# generate locales
locale-gen
# create locale.conf and set LANG variable
# /etc/locale.conf
# LANG=en_US.UTF-8
# --
# set console keyboard layout
# /etc/vconsole.conf
# KEYMAP=de-latin1

# network configuration
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# add user
useradd -m -G wheel -s /bin/zsh $USERNAME
# Set the initial password to username
echo"$USERNAME:$USERNAME" | chpasswd

# uncomment wheel definition with visudo or use sed command below 
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

# install user packages
pacman -Syu --noconfirm zsh neovim git less tree neofetch

# install desktop packages
pacman -Syu --noconfirm xorg plasma kde-applications sddm

# enable desktop manager
systemctl enable sddm

# enable network service
systemctl enable NetworkManager

# set root password
passwd
```

### Bootloader configuration
Source: [GRUB](https://wiki.archlinux.org/title/GRUB)
```bash
# install packages
# grub & efibootmgr were already installed before

# install GRUB
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB 

# generate GRUB configuration
grub-mkconfig -o /boot/grub/grub.cfg

# skip GRUB boot menu

```

### Reboot system and remove usb drive
```bash
# exit chroot and reboot
exit
reboot
```