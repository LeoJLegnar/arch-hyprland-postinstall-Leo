# arch-hyprland-postinstall-Leo

Este repositorio contiene un script en Bash para automatizar la configuración post-instalación de Arch Linux con el gestor de ventanas Hyprland. El script instala herramientas base, software común, configura el teclado, DNS, añade atajos personalizados a Hyprland y aplica algunas optimizaciones para sistemas con procesadores Ryzen y tarjetas gráficas NVIDIA GeForce RTX 4070 Ti (aunque algunas optimizaciones son genéricas).

## Contenido del Script

El script `arch-hyprland-postinstall-Leo` realiza las siguientes acciones:

1.  **Actualización del sistema:** Actualiza todos los paquetes del sistema a la última versión.
2.  **Instalación de herramientas base:** Instala herramientas esenciales como `git`, `curl`, `base-devel`, `wget`, `unzip` y `flatpak`.
3.  **Instalación de yay:** Clona, construye e instala el gestor de paquetes AUR `yay`.
4.  **Instalación de pamac:** Instala la interfaz gráfica para pacman y AUR, `pamac-aur`.
5.  **Instalación de herramientas del sistema:** Instala utilidades como `fastfetch`, `htop`, `btop`, `vlc` y `kdeconnect`.
6.  **Instalación de software multimedia, creativo y gaming:** Instala aplicaciones populares como `krita`, `blender`, `obs-studio`, `steam` y `lutris`. También instala desde Flatpak `Heroic Games Launcher`, `Discord`, `Spotify` y `WPS Office`.
7.  **Instalación de Vencord:** Utiliza el script oficial para instalar el cliente modificado de Discord, Vencord.
8.  **Instalación de Spicetify:** Instala la herramienta y los temas para personalizar la apariencia del cliente de Spotify.
9.  **Instalación de drivers Xencelabs:** Instala los drivers necesarios para tabletas gráficas Xencelabs.
10. **Instalación de dotfiles de end-4:** Ejecuta el script de instalación de los dotfiles del usuario `end-4`. **Nota:** Esto sobreescribirá tu configuración actual de Hyprland y otros programas configurados por estos dotfiles.
11. **Configuración del teclado:** Establece el layout del teclado a Inglés (US) con la variante AltGr para facilitar la escritura de caracteres internacionales como la 'ñ'. También añade el comando para configurar el teclado a la configuración de inicio de Hyprland.
12. **Configuración de DNS AdGuard:** Configura el sistema para utilizar los servidores DNS de AdGuard para bloqueo de publicidad y protección contra malware. También establece los servidores DNS de Cloudflare como fallback.
13. **Adición de atajos personalizados a Hyprland:** Crea el directorio de configuración de Hyprland si no existe y añade algunos atajos de teclado personalizados para lanzar aplicaciones comunes (Discord, Spotify, VLC, WPS Office, Krita, Blender, Heroic Games Launcher, Lutris, Steam, OBS Studio y KDE Connect). **Nota:** Estos atajos asumen que no solapan los atajos definidos en los dotfiles de end-4.
14. **Optimizaciones para Ryzen + 4070Ti:** Aplica las siguientes optimizaciones:
    * **Activación de zram:** Instala y configura `zram-generator` para crear un dispositivo de memoria comprimida en RAM, mejorando el rendimiento en sistemas con menos RAM.
    * **Activación del driver AMD P-State (si disponible):** Intenta activar el driver de rendimiento `amd_pstate` añadiéndolo a los parámetros del kernel en GRUB.
    * **Bajada de swappiness:** Reduce el valor de `vm.swappiness` para que el sistema sea menos propenso a usar el archivo de intercambio.
    * **Optimización de makepkg y pacman:** Configura `makepkg` para utilizar todos los núcleos del procesador durante la compilación de paquetes y aumenta el número de descargas paralelas en `pacman`.
15. **Habilitación de Flatpak y flathub:** Añade el repositorio de Flatpak `flathub` si no existe.
16. **Habilitación del recorte automático TRIM (SSD):** Activa el temporizador `fstrim.timer` para realizar el recorte automático en unidades de estado sólido (SSD), lo que ayuda a mantener su rendimiento.
17. **Mensaje de finalización:** Muestra un mensaje indicando que la post-instalación se ha completado y recomienda reiniciar el sistema.

## Cómo Utilizar

Para utilizar este script, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone [https://github.com/LeoJLegnar/arch-hyprland-postinstall-Leo.git](https://github.com/LeoJLegnar/arch-hyprland-postinstall-Leo.git)
    cd arch-hyprland-postinstall-Leo
    ```
2.  **Haz el script ejecutable:**
    ```bash
    chmod +x arch-hyprland-postinstall-Leo
    ```
3.  **Ejecuta el script como superusuario:**
    ```bash
    sudo ./arch-hyprland-postinstall-Leo
    ```

**Opción 2: Ejecutar directamente con `bash`**

Puedes ejecutar el script directamente descargándolo y ejecutándolo con `bash` en una sola línea:

```bash
bash <(curl -sL [https://raw.githubusercontent.com/LeoJLegnar/arch-hyprland-postinstall-Leo/main/arch-hyprland-postinstall-Leo.sh](https://raw.githubusercontent.com/LeoJLegnar/arch-hyprland-postinstall-Leo/main/arch-hyprland-postinstall-Leo.sh))

**Importante:**

* Se recomienda ejecutar este script en una instalación limpia de Arch Linux después de haber instalado Hyprland.
* El script utiliza la opción `--noconfirm` en los comandos de `pacman` y `yay`, lo que significa que no pedirá confirmación antes de instalar los paquetes. Asegúrate de revisar el script antes de ejecutarlo para entender qué se va a instalar.
* La instalación de los dotfiles de `end-4` **reemplazará tu configuración actual** de Hyprland y otros programas. Si deseas conservar tu configuración actual, comenta o elimina la sección correspondiente en el script.
* Las optimizaciones para Ryzen y la RTX 4070Ti son específicas para este hardware. Es posible que necesites ajustar o comentar estas secciones si tienes un hardware diferente.
* Después de ejecutar el script, es **altamente recomendable reiniciar el sistema** para que todos los cambios se apliquen correctamente.

## Advertencias

* Este script automatiza tareas y realiza cambios en la configuración del sistema. Úsalo bajo tu propio riesgo.
* Asegúrate de entender cada comando del script antes de ejecutarlo.
* Siempre es recomendable tener una copia de seguridad de tu sistema antes de realizar cambios importantes.

¡Disfruta de tu instalación de Arch Linux con Hyprland!
