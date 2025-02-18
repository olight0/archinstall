cfdisk
mkfs.ext4 /dev/sda3
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
pacman-key --init
pacman-key --populate
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot/efi
swapon /dev/sda2
pacstrap -K /mnt base base-devel git linux linux-firmware intel-ucode grub efibootmgr networkmanager neovim
genfstab -U /mnt >> /mnt/etc/fstab
read region
echo "what is your region (for timezone)"
arch-chroot /mnt -c 'ln -sf /usr/share/zoneinfo/$region /etc/localtime ; hwclock --systohc ; systemctl enable systemd-timesyncd ; nvim /etc/locale.gen ; nvim /etc/locale.conf ; locale-gen ; grub-install /dev/sda ; nvim /etc/default/grub ; grub-mkconfig -o /boot/grug/grub.cfg ; systemctl enable NetworkManager ; exit'
umount -a
reboot
