#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dotfiles config
for f in .zshrc .p10k.zsh .tmux.conf; do
  [[ -f "$HOME/$f" ]] || { echo "Falta $HOME/$f"; exit 1; }
done
for f in .zshrc .p10k.zsh .tmux.conf; do
  [[ ! -f "$HOME/$f" ]] || cp "$HOME/$f" "dotfiles/$f"
done
for d in bat btop fastfetch; do
  [[ ! -d "$HOME/.config/$d" ]] || { rm -rf "config/$d"; cp -a "$HOME/.config/$d" config/; }
done
if [[ -f dotfiles/.zshrc ]]; then
  sed -i 's|^export ZSH=.*|export ZSH="$HOME/.oh-my-zsh"|' dotfiles/.zshrc
fi
printf '%s\n' 'Configuración copiada. Revisa dotfiles/.zshrc antes de subirla: puede contener secretos o rutas locales.'
