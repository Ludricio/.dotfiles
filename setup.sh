#!/bin/bash
#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
export DOTFILES
export NVM_DIR="$HOME/.config/nvm"

echo "Bootstrapping dotfiles..."

bash "$DOTFILES/install-scripts/00-packages.sh"
bash "$DOTFILES/install-scripts/10-nvm.sh"
bash "$DOTFILES/install-scripts/20-git-aliases.sh"
bash "$DOTFILES/install-scripts/30-symlinks.sh"
bash "$DOTFILES/install-scripts/40-zsh.sh"
bash "$DOTFILES/install-scripts/50-nvim.sh"
bash "$DOTFILES/install-scripts/60-tmux.sh"

echo "✅ Dotfiles setup complete."
