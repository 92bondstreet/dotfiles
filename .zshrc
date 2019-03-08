# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME=""

export DISABLE_AUTO_TITLE=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git history history-substring-search npm zsh-autosuggestions zsh-syntax-highlighting terminalapp yarn)

# Start
source $ZSH/oh-my-zsh.sh

# oh-my-zsh overrides the prompt so Pure must be activated after source $ZSH/oh-my-zsh.sh.
autoload -U promptinit; promptinit
prompt pure

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin"

# Personal aliases
source ~/.aliases

# Default editor
export EDITOR="nano"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
