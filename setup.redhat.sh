
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
mv $HOME/.nvm $HOME/.config/nvm

sudo dnf copr enable tkbcopr/fd
sudo dnf install fd

sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf install ripgrep
