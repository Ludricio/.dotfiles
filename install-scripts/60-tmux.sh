#!/usr/bin/env bash
set -euo pipefail

echo "Setting up Tmux..."

clone_or_update() {
  repo=$1
  target=$2
  if [[ -d $target/.git ]]; then
    git -C "$target" pull --ff-only
  else
    git clone "$repo" "$target"
  fi
}

clone_or_update https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo "✅ Tmux configured"
