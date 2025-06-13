#!/bin/bash
set -e

echo ">>> Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo ">>> Instalando herramientas base..."
sudo pacman -S --noconfirm git curl base-devel wget unzip flatpak

echo ">>> Instalando yay..."
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo ">>> Instalando pamac..."
yay -S --noconfirm pamac-aur

echo ">>> Instalando herramientas del sistema..."
sudo pacman -S --noconfirm fastfetch htop btop vlc kdeconnect

echo ">>> Instalando software multimedia, creativo y gaming..."
sudo pacman -S --noconfirm krita blender obs-studio steam lutris
flatpak install -y flathub \
  com.heroicgameslauncher.hgl \
  com.discordapp.Discord \
  com.spotify.Client \
  com.wps.Office

echo ">>> Instalando VsCode..."
yay -S --noconfirm code

echo ">>> Instalando Vencord..."
bash <(curl -s https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)

echo ">>> Instalando Spicetify..."
yay -S --noconfirm spicetify-cli spicetify-themes

echo ">>> Instalando drivers Xencelabs..."
yay -S --noconfirm xencelabs-drivers

echo ">>> Instalando dotfiles de end-4..."
bash <(curl -sL https://raw.githubusercontent.com/end-4/dotfiles/main/install.sh)

echo ">>> Configurando teclado español con ñ..."
# localectl set-x11-keymap es
# echo "setxkbmap es" >> ~/.config/hypr/exec.conf
echo ">>> Configurando teclado us con variant altgr-intl..."
localectl set-x11-keymap us,us -variant altgr-intl
echo "setxkbmap us -variant altgr-intl" >> ~/.config/hypr/exec.conf

echo ">>> Configurando DNS AdGuard..."
sudo mkdir -p /etc/systemd/resolved.conf.d
echo -e "[Resolve]\nDNS=94.140.14.14 94.140.15.15\nFallbackDNS=1.1.1.1" | sudo tee /etc/systemd/resolved.conf.d/adguard.conf
sudo systemctl restart systemd-resolved

echo ">>> Agregando atajos personalizados a Hyprland..."
CONFIG=~/.config/hypr/hyprland.conf

mkdir -p ~/.config/hypr

echo -e "
# Atajos personalizados (sin solapar end-4)

bind = SUPER, ctrl+D, exec, discord
bind = SUPER, ctrl+M, exec, flatpak run com.spotify.Client
bind = SUPER, ctrl+V, exec, vlc
bind = SUPER, ctrl+W, exec, flatpak run com.wps.Office
bind = SUPER, ctrl+K, exec, krita
bind = SUPER, ctrl+B, exec, blender
bind = SUPER, ctrl+H, exec, flatpak run com.heroicgameslauncher.hgl
bind = SUPER, ctrl+L, exec, lutris
bind = SUPER, ctrl+G, exec, steam
bind = SUPER, ctrl+O, exec, obs
bind = SUPER, ctrl+C, exec, kdeconnect-app
bind = SUPER, ctrl+X, exec, code
" >> "$CONFIG"

echo ">>> Optimizaciones para Ryzen + 4070Ti..."

echo ">>> 1. Activando zram..."
sudo pacman -S --noconfirm zram-generator
echo -e "[zram0]\n  zram-size = ram\n  compression-algorithm = zstd" | sudo tee /etc/systemd/zram-generator.conf
sudo systemctl daemon-reexec
sudo systemctl restart systemd-zram-setup@zram0.service

echo ">>> 2. Activando AMD P-State driver (si disponible)..."
echo 'amd_pstate=active' | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo ">>> 3. Bajando swappiness..."
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf

echo ">>> 4. Optimizando makepkg para más núcleos..."
sudo sed -i "s/^#MAKEFLAGS.*/MAKEFLAGS=\"-j$(nproc)\"/" /etc/makepkg.conf
sudo sed -i "s/^#ParallelDownloads.*/ParallelDownloads = 10/" /etc/pacman.conf

echo ">>> Habilitando Flatpak y flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ">>> Habilitando recorte automático TRIM (SSD)..."
sudo systemctl enable fstrim.timer

echo ">>> ¡Post-instalación completada! Reinicia para aplicar todo."
