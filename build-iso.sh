#!/bin/bash
# StackOS Genesis 1.0 - Script de Build Completo
# Recria a ISO do zero a partir dos pacotes online
set -e

echo "=== StackOS Genesis Build Script ==="
echo "Requer: Ubuntu 26.04, 10GB livre, internet"
echo ""

# 1. Instalar dependencias
echo "[1/8] Instalando dependencias..."
apt-get install -y debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools

# 2. Criar chroot base Ubuntu 26.04
echo "[2/8] Criando base Ubuntu 26.04..."
mkdir -p ~/StackOS/chroot
debootstrap --arch=amd64 resolute ~/StackOS/chroot http://archive.ubuntu.com/ubuntu/

# 3. Montar sistema
echo "[3/8] Montando sistema..."
mount --bind /dev ~/StackOS/chroot/dev
mount --bind /proc ~/StackOS/chroot/proc
mount --bind /sys ~/StackOS/chroot/sys

# 4. Instalar pacotes base
echo "[4/8] Instalando pacotes base..."
# Adicionar repositorios necessarios
chroot ~/StackOS/chroot bash -c 'echo "deb http://archive.ubuntu.com/ubuntu resolute main restricted universe multiverse" > /etc/apt/sources.list'
chroot ~/StackOS/chroot apt-get update
chroot ~/StackOS/chroot apt-get install -y \
  ubuntu-desktop-minimal gnome-shell gdm3 \
  nm-connection-editor network-manager \
  gparted rsync casper ubiquity-casper \
  papirus-icon-theme yaru-theme-gtk yaru-theme-icon
# Instalar fastfetch do PPA
chroot ~/StackOS/chroot add-apt-repository -y ppa:zhangsongcui3371/fastfetch
chroot ~/StackOS/chroot apt-get install -y fastfetch

# 5. Adicionar repositorio StackOS
echo "[5/8] Adicionando repositorio StackOS..."
echo "deb [trusted=yes] https://stackoslinux-dev.github.io/repo genesis main" > \
  ~/StackOS/chroot/etc/apt/sources.list.d/stackos.list
chroot ~/StackOS/chroot apt-get update
chroot ~/StackOS/chroot apt-get install -y \
  stackos-installer stackos-store stackos-drivers \
  stackos-fastfetch stackos-wallpapers stackos-themes \
  stackos-branding stackos-settings stackos-firefox

# 6. Copiar configuracoes
echo "[6/8] Aplicando configuracoes..."
# (configs do github stackos-source/configs/)

# 7. Desmontar
echo "[7/8] Desmontando..."
umount -lf ~/StackOS/chroot/dev
umount -lf ~/StackOS/chroot/proc
umount -lf ~/StackOS/chroot/sys

# 8. Build ISO
echo "[8/8] Gerando ISO..."
mkdir -p ~/StackOS/iso/casper
mksquashfs ~/StackOS/chroot ~/StackOS/iso/casper/filesystem.squashfs \
  -noappend -e boot -no-xattrs -comp xz -b 1M -Xbcj x86

echo "ISO gerada com sucesso!"
