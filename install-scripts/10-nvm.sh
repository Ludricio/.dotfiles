#!/usr/bin/env bash
set -euo pipefail

echo "Setting up NVM + Node..."

mkdir -p "$NVM_DIR"
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load nvm if available
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 22 >/dev/null
nvm use 22 >/dev/null
nvm alias default 22 >/dev/null

echo "✅ NVM + Node installed"
