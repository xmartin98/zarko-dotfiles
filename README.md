# zarko-dotfiles

En Ubuntu original: `bash backup.sh`. Revisa los archivos exportados antes de subirlos a un repositorio privado. No se exportan fuentes, credenciales Git ni historial. No publiques secretos que puedan estar en .zshrc.

En Ubuntu/WSL destino: `bash install.sh`, `chsh -s "$(command -v zsh)"`, `exec zsh`. Algunos paquetes pueden faltar según la versión de Ubuntu; revisa los avisos del instalador y desactiva los alias correspondientes o instala los paquetes por separado. Se guardan copias de las configuraciones existentes. Git Delta se configura globalmente si está instalado. No se copia la identidad Git.

En Windows Terminal instala MesloLGS NF en Windows (https://github.com/romkatv/powerlevel10k#fonts), selecciona la fuente en el perfil Ubuntu y escoge el esquema de colores oscuro. Ptyxis no se exporta en este proyecto. No se activa Fastfetch automáticamente salvo que tu .zshrc exportado lo haga.

## Corrección de Ptyxis
En Ubuntu nativo el instalador intenta aplicar `gsettings set org.gnome.Ptyxis font-name 'MesloLGS NF 13'` y desactivar la fuente del sistema. Selecciona la paleta VS Code manualmente. No se aplica en WSL.

## Windows Terminal
El archivo `windows-terminal-scheme.json` es un esquema aproximado a VS Code Dark+. Añade su objeto al array `schemes` del settings.json de Windows Terminal (no reemplaces el archivo completo). Selecciona Zarko Dark y MesloLGS NF, tamaño 13, en el perfil Ubuntu. Las fuentes se descargan desde el enlace oficial, no están incluidas.

## Seguridad y portabilidad
Revisa los dotfiles y config antes de git add: pueden contener secretos o rutas absolutas. El instalador modifica la configuración global de Delta, no la identidad Git. No se exporta el historial ni la base de datos de Zoxide. No se cambian automáticamente las preferencias de Windows. Si un paquete no está disponible en una versión anterior de Ubuntu, instala una alternativa o ajusta sus alias. Usa un repositorio privado. Los scripts se invocan con bash para evitar problemas de permisos tras descomprimir.
