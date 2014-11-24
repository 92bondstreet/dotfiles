# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="pure"

export DISABLE_AUTO_TITLE=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git zsh-syntax-highlighting)

# Start
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin"

# Personal aliases
source ~/.aliases

# TMUX
export EDITOR='nano'
source ~/.bin/tmuxinator.zsh
