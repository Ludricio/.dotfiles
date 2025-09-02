#!/usr/bin/env bash
set -euo pipefail

echo "Setting up symlinks..."

linkfile() {
  src=$1
  dest=$2
  if [[ -L $dest ]]; then
    unlink "$dest"
  elif [[ -e $dest ]]; then
    echo "⚠️  $dest exists and is not a symlink. Backing up to $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sf "$src" "$dest"
}

mkdir -p "$HOME/.config" "$HOME/.local/bin"

if command -v fdfind >/dev/null 2>&1; then
  linkfile "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

linkfile "$DOTFILES/.zsh/.zshenv" "$HOME/.zshenv"
linkfile "$DOTFILES/.zsh" "$HOME/.zsh"
linkfile "$DOTFILES/nvim/.config/nvim" "$HOME/.config/nvim"
linkfile "$DOTFILES/nvim/.config/nvim/nvim.appimage" "$HOME/.local/bin/nvim"
linkfile "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "✅ Symlinks set up"
