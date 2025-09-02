#!/usr/bin/env bash
set -euo pipefail

echo "Installing system packages..."

if command -v apt >/dev/null 2>&1; then
  PKG="apt"
  sudo apt update -y
  sudo apt install -y \
    gcc \
    make \
    zip \
    fzf \
    htop \
    zsh \
    ripgrep \
    fd-find \
    libfuse2

elif command -v dnf >/dev/null 2>&1; then
  PKG="dnf"
  sudo dnf install -y \
    gcc \
    make \
    zip \
    fzf \
    htop \
    zsh

  # RedHat/RHEL specific extras
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  mv "$HOME/.nvm" "$HOME/.config/nvm"

  sudo dnf copr enable -y tkbcopr/fd
  sudo dnf install -y fd

  sudo subscription-manager repos --enable "codeready-builder-for-rhel-9-$(arch)-rpms"
  sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
  sudo dnf install -y ripgrep
else
  echo "❌ No supported package manager found (apt/dnf)."
  exit 1
fi

echo "✅ Packages installed"
