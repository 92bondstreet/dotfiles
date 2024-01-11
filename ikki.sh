#!/bin/bash

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "🧹 $b$d ${S[$s]} of space was cleaned up"
}

useless () {
  echo "🍎 Removing useless Applications..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/useless.sh)"
}

mac_cleanup () {
  echo "🧹 Cleanup - in larger way - based on fwartner/mac-cleanup and mengfeng/clean-my-mac..."
  oldAvailable=$(df / | tail -1 | awk '{print $4}')
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/mengfeng/clean-my-mac/master/clean_my_mac.sh)"
  newAvailable=$(df / | tail -1 | awk '{print $4}')
  count=$((oldAvailable - newAvailable))
  bytesToHuman $count

}

bootstrap () {
  echo "💻 Bootstraping..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/bootstrap.sh)"
}

macos () {
  echo "🍎 Overriding macos preferences..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/macos.sh)"
}

todo () {
  echo "🎯 Todo list"
  echo "Execute 'open ~/Downloads/TomorrowNightEighties.terminal'"
  echo "Open Terminal > Preferences > Profiles > choose TomorrowNightEighties theme"
  echo "Generate a new SSH key Add the SSH key to GitHub https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
  echo "GITHUB_TOKEN=<token> GIST_ID=<id> atom"
  echo "Disable and remove Siri from Menu Bar"
  echo "Rearrange apps from Mission Control"
}

help()
{
   # Display Help
   echo "1 command to rebirth like Ikki."
   echo
   echo "Syntax: ikki [-c|b|m|t]"
   echo "options:"
   echo "c     🧹 Cleanup - in larger way."
   echo "b     💻 Bootstraping."
   echo "m     🍎 Overriding macos preferences."
   echo "t     🎯 Todo list."
   echo
}


while getopts :h.c.b.m.t. flag
do
    case "${flag}" in
        c) mac_cleanup;;
        b) bootstrap;;
        m) macos;;
        t) todo;;
        h) help;;
    esac
done

#useless # doesnt' work with mojave
#mac_cleanup
#bootstrap
#macos
#todo

