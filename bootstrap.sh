#!/bin/bash

# Thanks to https://github.com/MikeMcQuaid/strap/blob/master/bin/strap.sh

sudo -v

echo "🔓 Keeping sudo alive..."
# Keep-alive: update existing `sudo` time stamp until osx.sh has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

security () { 
  echo "👮‍♀️ Setting a better security"
  defaults write com.apple.Safari \
    com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled \
    -bool false
  defaults write com.apple.Safari \
    com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles \
    -bool false
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
  launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist 2>/dev/null
}

folders () {
  echo "🌳 Creating structure..."
  mkdir -p ~/dev
  mkdir -p ~/labs
}

dotfiles () {
  echo "🔑 Dowloading dotfiles..."
  curl -o ~/.aliases https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.aliases
  curl -o ~/.editorconfig https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.editorconfig
  curl -o ~/.gitconfig https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.gitconfig
  curl -o ~/.gitignore https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.gitignore
  curl -o ~/.nanorc https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.nanorc
}

homebrew () {
  echo "📦 Installation Homebrew..."
  # curl -o ~/.Brewfile https://raw.githubusercontent.com/92bondstreet/dotfiles/master/Brewfile
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew bundle --file=~/.Brewfile
  # use these tools over their Mac counterparts
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
  brew upgrade
  brew cleanup -s &>/dev/null
  #brew cask cleanup &>/dev/null
  rm -rfv $(brew --cache) &>/dev/null
  brew tap --repair &>/dev/null
}

zsh () {
  echo "🎨 Installing zsh"
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  curl -o ~/Downloads/TomorrowNightEighties.terminal -l https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night%20Eighties.terminal | sh
  # curl -o ~/.zshrc https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.zshrc
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

nvm () {
  echo "🚀 Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  source ~/.zshrc
  nvm install node
}

terminal () {
  echo "🖥️ Theming the terminal"
  npm install --global pure-prompt
  source ~/.zshrc
  mkdir -p ~/.nano/syntax
  curl -o ~/.nano/syntax/Dockerfile.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/Dockerfile.nanorc
  curl -o ~/.nano/syntax/git.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/git.nanorc
  curl -o ~/.nano/syntax/js.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/js.nanorc
  curl -o ~/.nano/syntax/markdown.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/markdown.nanorc
  curl -o ~/.nano/syntax/patch.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/patch.nanorc
}

help()
{
   # Display Help
   echo "1 command to rebirth like Ikki."
   echo
   echo "Syntax: bootstrap [-c|b|m|t]"
   echo "options:"
   echo "s     👮‍♀️ Setting a better security"
   echo "f     🌳 Creating structure."
   echo "d     🔑 Dowloading dotfiles..."
   echo "b     📦 Installation Homebrew..."
   echo "z     🎨 Installing zsh"
   echo "n     🚀 Installing nvm"
   echo "t     🖥️  Theming the terminal"
   echo
}


while getopts :h.c.b.m.t. flag
do
    case "${flag}" in
        s) security;;
        f) folder;;
        d) dotfiles;;
        b) homebrew;;
        z) zsh;;
        n) nvm;;
        n) terminal;;
        h) help;;
    esac
done