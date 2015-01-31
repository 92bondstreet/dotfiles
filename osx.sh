#!/bin/bash

## Bootstrap to install new MAC OSX development environment

## Custom echo
red='\033[0;31m'
yellow='\033[0;33m'
green='\033[0;32m'

## Color-echo.
#  Reset text attributes to normal + without clearing screen.
alias Reset="tput sgr0"
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}"
  Reset # Reset to normal.
  return
}

## HOMEBREW
cecho "Homebrew installation ? (y/n)" $red
read -r response
case $response in
  [yY])
    # Check for Homebrew,
    # Install if we don't have it
    if test ! $(which brew); then
      cecho "Installing homebrew..." $yellow
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Update homebrew recipes
    brew update

    ## CASK INSTALLATION
    brew install caskroom/cask/brew-cask

    cecho "Homebrew and cask installed..." $green

    break;;
  *) break;;
esac

## GNU Utilities
cecho "GNU Utilities installation ? (y/n)" $red
read -r response
case $response in
  [yY])

    cecho "Installing GNU utilities..." $yellow

    # Install GNU core utilities (those that come with OS X are outdated)
    brew install coreutils

    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    brew install findutils

    # Install Bash 4
    brew install bash

    # Install more recent versions of some OS X tools
    brew tap homebrew/dupes
    brew install homebrew/dupes/grep

    # use these tools over their Mac counterparts
    $PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

    cecho "GNU utilities installed" $green

    break;;
  *) break;;
esac

## BINARIES INSTALLATION
cecho "Binaries installation ? (y/n)" $red
read -r response
case $response in
  [yY])

    # Tips on some binaries
    # https://medium.com/dev-tricks/mount-a-remote-filesystem-with-sshfs-8a37e85b39ee
    binaries=(
    ack
    git
    mercurial
    node
    python
    ruby
    sshfs
    tmux
    trash
    tree
    wget
    z
    zsh
    )

    cecho "installing binaries..." $yellow
    brew install ${binaries[@]}

    brew cleanup

    cecho "Binaries installed" $green

    break;;
  *) break;;
esac

## APPS INSTALLATION
cecho "Apps installation ? (y/n)" $red
read -r response
case $response in
  [yY])
    apps=(
    alfred
    atom
    firefox
    flash
    google-chrome
    kdiff3
    mou
    slack
    sourcetree
    spectacle
    skype
    transmit
    vagrant
    virtualbox
    )

    # Install apps to /Applications
    # Default is: /Users/$user/Applications
    cecho "installing apps..." $yellow
    brew cask install --appdir="/Applications" ${apps[@]}

    # Add link for alfred
    brew cask alfred link

    cecho "Apps installed" $green

    break;;
  *) break;;
esac

## FONT
cecho "Fonts installation ? (y/n)" $red
read -r response
case $response in
  [yY])
    brew tap caskroom/fonts

    fonts=(
      font-source-code-pro
      font-droid-sans-mono
    )

    # install fonts
    cecho "installing fonts..." $yellow
    brew cask install ${fonts[@]}

    cecho "Fonts installed" $green

    break;;
  *) break;;
esac

## Terminal
cecho "Terminal installation ? (y/n)" $red
read -r response
case $response in
  [yY])
    cecho "Downloading oh-my-zsh..." $yellow
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

    #Solorized themes...
    cecho "Downloading Solorized Themes..." $yellow
    curl -o ~/Downloads/solarized.zip http://ethanschoonover.com/solarized/files/solarized.zip

    # Pure themes
    cecho "Download pure theme..."$yellow
    curl -o ~/.oh-my-zsh/themes/pure.zsh-theme -l https://raw.githubusercontent.com/92bondstreet/dotfiles/master/pure.zsh

    # Tomorrow Night Eighties
    cecho "Download Tomorrow Night Eighties theme..."$yellow
    curl -o ~/Downloads/TomorrowNightEighties.terminal -l https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/OS%20X%20Terminal/Tomorrow%20Night%20Eighties.terminal | sh

    # zsh-syntax-highlighting
    cecho "Download zsh-syntax-highlighting plugin..."$yellow
    cd ~/.oh-my-zsh/custom/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

    # k
    cecho "Download k script..."$yellow
    mkdir ~/.k
    cd ~/.k
    curl -o k.sh -l https://raw.githubusercontent.com/supercrabtree/k/master/k.sh

    cecho "Terminal installed" $green

    break;;
  *) break;;
esac

## http://jakoblaegdsmand.com/blog/2013/04/how-to-get-an-awesome-looking-terminal-on-mac-os-x/

## OSX for hackers
# https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
