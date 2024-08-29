#!/bin/bash
DOTFILES="$HOME/.dotfiles";
NVIM="$DOTFILES/nvim/.config/nvim"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

pkgmgr=($whereis apt)

#check if first argument is the string "redhat"
if [[ $1 == "redhat" ]]; then
	pgkmkgr=($whereis dnf)
	source  $DOTFILES/setup.redhat.sh
else
	sudo apt install ripgrep -y
	sudo apt install fd-find -y
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

function linkfile(){
	if [[ -L $2 ]]; then
		unlink $2
	fi
	ln -sf $1 $2
}
mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

sudo apt update
sudo apt install zsh -y
sudo apt install fuse -y 
sudo apt install gcc -y
sudo apt install zip -y

export NVM_DIR="$HOME/.config/nvm"
nvm install 21
nvm use 21

cd $DOTFILES
git submodule update --init

#Git alias
git config --global alias.lg1 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
git config --global alias.lg2 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
git config --global alias.lg lg1

linkfile -s $(which fdfind) $HOME/.local/bin/fd

linkfile "$DOTFILES/.zsh/.zshenv" "$HOME/.zshenv"
linkfile "$DOTFILES/.zsh" "$HOME/.zsh"

#Neovim
linkfile "$NVIM" "$HOME/.config/nvim"
linkfile "$NVIM/nvim.appimage" "$HOME/.local/bin/nvim"

#tmux
linkfile "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

#zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k	

git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1  https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

rm $HOME/.zshrc
chsh -s $(which zsh) $(whoami)
echo "Done\n"
