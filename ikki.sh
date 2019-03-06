#!/bin/bash

useless () {
  echo "🍎 Removing useless Applications..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/useless.sh)"
}

mac_cleanup () {
  echo "🧹 Cleanup - in larger way - based on fwartner/mac-cleanup and mengfeng/clean-my-mac..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/fwartner/mac-cleanup/master/cleanup.sh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/mengfeng/clean-my-mac/master/clean_my_mac.sh)"
}

osx () {
  echo "💻 Bootstraping..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/osx.sh)"
}

useless
mac_cleanup
osx
