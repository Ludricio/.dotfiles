#!/bin/bash
DOTFILES="$HOME/.dotfiles";
NVIM="$DOTFILES/nvim/.config/nvim"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

function linkfile(){
	if [[ -L $2 ]]; then
		unlink $2
	fi
	ln -s $1 $2
}
mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

sudo apt update
sudo apt install zsh -y
sudo apt install fuse -y 
sudo apt install gcc -y
sudo apt install ripgrep -y
sudo apt install fd-find -y
sudo apt install zip -y

cd $DOTFILES
git submodule update --init

linkfile -s $(which fdfind) $HOME/.local/bin/fd

linkfile "$DOTFILES/.zsh/.zshenv" "$HOME/.zshenv"
linkfile "$DOTFILES/.zsh" "$HOME/.zsh"

#Neovim
linkfile "$NVIM" "$HOME/.config/nvim"
linkfile "$NVIM/nvim.appimage" "$HOME/.local/bin/nvim"

#zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k	

git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1  https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

rm $HOME/.zshrc
chsh -s $(which zsh) $(whoami)
echo "Done\n"
