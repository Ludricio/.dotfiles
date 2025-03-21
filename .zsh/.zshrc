# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

setopt globdots 
setopt ignoreeof
unsetopt BEEP

export ZSH="$HOME/.oh-my-zsh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_BIN_HOME="$HOME/.local/bin"
export PATH=$HOME/.local/bin:$PATH
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump/.zcomdump"

# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="sunrise"
ZSH_THEME="robbyrussell"

# Set list of plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/.zsh_profile
autoload -U compinit -d $XDG_CACHE_HOME/zsh/zcompdump/.zcomdump

# lazy load nvm and node
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use default --silent

source $HOME/.dotfiles/.ssh/.sshsetup 


# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
# [[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
