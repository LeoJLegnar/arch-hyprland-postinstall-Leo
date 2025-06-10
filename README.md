# Script de Post-Instalación para Arch Linux + Hyprland

Este script automatiza la configuración inicial de Arch Linux con el entorno gráfico **Hyprland**, instalando herramientas esenciales para productividad, multimedia, ilustración digital y gaming, junto con optimizaciones para hardware moderno como CPUs AMD Ryzen y GPUs NVIDIA RTX.

## 🔧 ¿Qué hace este script?

- Actualiza el sistema.
- Instala herramientas base (`git`, `yay`, `flatpak`, etc).
- Instala software esencial y multimedia (Krita, Blender, VLC, OBS Studio, Steam, Lutris, etc).
- Instala aplicaciones desde Flathub como Spotify, Heroic Games Launcher, Discord y WPS Office.
- Configura drivers para tabletas gráficas **Xencelabs**.
- Instala los dotfiles del usuario [`end-4`](https://github.com/end-4/dotfiles).
- Añade atajos personalizados en Hyprland.
- Configura el teclado con el layout **US con AltGr Intl** para facilitar el uso de la ñ y otros símbolos.
- Configura DNS usando **AdGuard**.
- Aplica varias **optimizaciones de sistema** para mejorar el rendimiento y la experiencia.

## ⚙️ Requisitos

- Arch Linux instalado y funcional.
- Hyprland ya instalado y configurado mínimamente.
- Acceso a sudo.
- Conexión a internet activa.

## 🚀 Instalación

Puedes ejecutar el script directamente con `bash`:

```bash
bash <(curl -sL https://raw.githubusercontent.com/LeoJLegnar/arch-hyprland-postinstall-Leo/main/arch-hyprland-postinstall-Leo.sh)