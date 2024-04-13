#!/bin/bash
local DOTFILES="$( dirname -- "$BASH_SOURCE"; )";

local ZSH=true

if [ $ZSH = true ]; then
	if [ ! -d "$HOME/.oh-my-zh" ]; then
		echo "Install zsh and oh-my-zsh first"
		echo 'Remember to run chsh -s `$(whereis zsh)`'
		exit -1
	fi
fi

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

echo "Done\n"
