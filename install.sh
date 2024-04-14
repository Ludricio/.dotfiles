#!/bin/bash
local DOTFILES="$( dirname -- "$BASH_SOURCE"; )";
local NVIM="$DOTFILES/nvim/.config/nvim"

local ZSH=true

if [ $ZSH = true ]; then
	if [ ! -d "$HOME/.oh-my-zh" ]; then
		echo "Install zsh and oh-my-zsh first"
		echo 'Remember to run chsh -s `$(whereis zsh)`'
		exit -1
	fi
fi


mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

#Requirements
sudo apt install gcc -y
sudo apt install ripgrep -y
sudo apt install fd-find -y

ln -s $(which fdfind) $HOME/.local/bin/fd

#ZSH
if [ $ZSH = true ]; then
	unlink $HOME/.zshenv
	unlink $HOME/.zsh
	ln -s $DOTFILES/.zshenv $HOME/.zshenv
	ln -s $DOTFILES/.zsh $HOME/.zsh

	git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k	

	git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone --depth 1  https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

fi

#Neovim
ln -s $NVIM $HOME/.config/nvim
ln -s $NVIM/nvim.appimage $HOME/.local/bin/nvim
echo "Done\n"
