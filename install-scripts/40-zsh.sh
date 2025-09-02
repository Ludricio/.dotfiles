#!/usr/bin/env bash
set -euo pipefail

echo "Configuring zsh..."

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Attempt unattended install if supported
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
    echo "Unattended installer failed or is broken—falling back to manual git clone"
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
  }
else
  git -C "$HOME/.oh-my-zsh" pull --ff-only
fi

# Plugin setup
clone_or_update() {
  repo=$1; target=$2
  if [[ -d $target/.git ]]; then
    git -C "$target" pull --ff-only
  else
    git clone --depth=1 "$repo" "$target"
  fi
}
clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_or_update https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"

# Backup .zshrc if not a symlink
if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Set Zsh as default shell if it isn’t already
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  chsh -s "$(command -v zsh)" "$(whoami)" || true
fi

echo "✅ Zsh configured"
