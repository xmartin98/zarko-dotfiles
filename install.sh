#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
ROOT=$PWD
for f in .zshrc .p10k.zsh .tmux.conf; do
  [[ -f "$ROOT/dotfiles/$f" ]] || { echo "Falta dotfiles/$f: ejecuta backup.sh en el equipo original."; exit 1; }
done
sudo apt update
sudo apt install -y zsh git curl ca-certificates fontconfig
while read -r pkg; do
  [[ -n "$pkg" ]] || continue
  if apt-cache show "$pkg" >/dev/null 2>&1; then
    sudo apt install -y "$pkg" || echo "No se pudo instalar $pkg"
  else
    echo "Paquete no disponible: $pkg"
  fi
done < packages.txt
clone() {
  if [[ -d "$2/.git" ]]; then return; fi
  git clone --depth 1 "$1" "$2"
}
clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
custom="$HOME/.oh-my-zsh/custom"
mkdir -p "$custom/themes" "$custom/plugins"
clone https://github.com/romkatv/powerlevel10k.git "$custom/themes/powerlevel10k"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  clone "https://github.com/zsh-users/$plugin.git" "$custom/plugins/$plugin"
done
backup=$(mktemp -d "$HOME/terminal-restore.XXXXXXXX")
mkdir -p "$backup/config" "$HOME/.config"
for f in .zshrc .p10k.zsh .tmux.conf; do
  [[ ! -e "$HOME/$f" ]] || cp -a "$HOME/$f" "$backup/"
  cp --remove-destination "$ROOT/dotfiles/$f" "$HOME/$f"
done
# Replace the original user's home path in the exported shell files when necessary.
# Review any machine-specific settings manually.
for d in bat btop fastfetch; do
  [[ -d "$ROOT/config/$d" ]] || continue
  [[ ! -d "$HOME/.config/$d" ]] || cp -a "$HOME/.config/$d" "$backup/config/"
  cp -a "$ROOT/config/$d" "$HOME/.config/"
done
if command -v batcat >/dev/null; then batcat cache --build; elif command -v bat >/dev/null; then bat cache --build; fi
if command -v delta >/dev/null; then
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global delta.navigate true
  git config --global delta.side-by-side true
  git config --global delta.line-numbers true
  git config --global delta.dark true
fi
if ! grep -qi microsoft /proc/sys/kernel/osrelease; then
  mkdir -p "$HOME/.local/share/fonts"
  for style in Regular Bold Italic 'Bold Italic'; do
    curl -fL "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20${style// /%20}.ttf" -o "$HOME/.local/share/fonts/MesloLGS NF $style.ttf"
  done
  fc-cache -f
  if command -v gsettings >/dev/null && gsettings list-schemas | grep -Fx org.gnome.Ptyxis >/dev/null; then
    if ! (gsettings get org.gnome.Ptyxis font-name > "$backup/ptyxis-font.txt" && gsettings get org.gnome.Ptyxis use-system-font > "$backup/ptyxis-system-font.txt" && gsettings set org.gnome.Ptyxis font-name "MesloLGS NF 13" && gsettings set org.gnome.Ptyxis use-system-font false); then
      echo "No se pudo configurar Ptyxis; selecciona MesloLGS NF 13 manualmente."
    fi
  fi
else
  echo 'WSL: instala MesloLGS NF en Windows y selecciónala en Windows Terminal.'
fi
printf 'Backup anterior: %s\n' "$backup"
echo 'Revisa ~/.zshrc para rutas absolutas y alias de paquetes no disponibles.'
echo 'Para activar Zsh: chsh -s "$(command -v zsh)"; después exec zsh'
