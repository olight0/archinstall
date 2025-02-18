exec cfdisk
exec mkfs.ext4 /dev/sda3
exec mkfs.fat -F 32 /dev/sda1
exec mkswap /dev/sda2
exec pacman-key --init
exec pacman-key --populate
exec mount /dev/sda3 /mnt
exec mount --mkdir /dev/sda1 /mnt/boot/efi
exec swapon /dev/sda2
exec pacstarp -K /mnt base base-devel git linux linux-firmware intel-ucode grub efibootmgr networkmanager neovim
exec genfstab -U /mnt >> /mnt/etc/fstab
read region
echo "what is your region (for timezone)"
exec arch-chroot /mnt -c 'ln -sf /usr/share/zoneinfo/$region /etc/localtime ; hwclock --systohc ; systemctl enable systemd-timesyncd ; nvim /etc/locale.gen ; nvim /etc/locale.conf ; locale-gen ; grub-install /dev/sda ; nvim /etc/default/grub ; grub-mkconfig -o /boot/grug/grub.cfg ; systemctl enable NetworkManager ; exit'
exec umount -a
exec reboot
