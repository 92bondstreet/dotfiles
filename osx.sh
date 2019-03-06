#!/bin/bash

# Thanks to https://github.com/MikeMcQuaid/strap/blob/master/bin/strap.sh

sudo -v

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
sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist 2>/dev/null

echo "🌳 Creating structure..."
mkdir -p ~/dev
mkdir -p ~/labs

echo "🔑 Dowloading dotfiles..."
curl -o "~/.aliases" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.aliases
curl -o "~/.editorconfig" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.editorconfig
curl -o "~/.gitconfig" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.gitconfig
curl -o "~/.gitignore" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.gitignore
curl -o "~/.nanorc" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/.nanorc

echo "📦 Installation Homebrew..."
curl -o "~/.Brewfile" https://raw.githubusercontent.com/92bondstreet/dotfiles/master/Brewfile
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew bundle -f "~/.Brewfile"

# use these tools over their Mac counterparts
$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

brew upgrade
brew cleanup -s &>/dev/null
#brew cask cleanup &>/dev/null
rm -rfv $(brew --cache) &>/dev/null
brew tap --repair &>/dev/null

echo "🚀 Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
source ~/.zshrc
nvm install node

echo "🖥️ Theming the terminal"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
curl -o ~/Downloads/solarized.zip http://ethanschoonover.com/solarized/files/solarized.zip
curl -o ~/Downloads/TomorrowNightEighties.terminal -l https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night%20Eighties.terminal | sh
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
npm install --global pure-prompt
mkdir -p ~/.nano/syntax
cd ~/.nano/syntax
curl -o Dockerfile.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/Dockerfile.nanorc
curl -o git.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/git.nanorc
curl -o javascript.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/javascript.nanorc
curl -o json.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/json.nanorc
curl -o markdown.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/markdown.nanorc
curl -o patch.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/patch.nanorc
curl -o sh.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/sh.nanorc
curl -o zsh.nanorc -l https://raw.githubusercontent.com/scopatz/nanorc/master/zsh.nanorc

## more space display
## remove all icon from dock
