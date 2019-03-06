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
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/fwartner/mac-cleanup/master/cleanup.sh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/mengfeng/clean-my-mac/master/clean_my_mac.sh)"
  newAvailable=$(df / | tail -1 | awk '{print $4}')
  count=$((oldAvailable - newAvailable))
  bytesToHuman $count

}

osx () {
  echo "💻 Bootstraping..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/92bondstreet/dotfiles/master/osx.sh)"
}

#useless # doesnt' work with mojave
mac_cleanup
osx
