#!/bin/bash

# remove useless macos Applications
# Thanks to
# https://github.com/uybinh/macos-setup/blob/7d07c6a1532ed938522587458f12d602ef6350fc/lib/shrink.sh
# https://github.com/derhuerst/osx-setup/blob/a551d1dfdebc3f245881a35bbe45aebe03b0fe1f/lib/shrink.sh

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "$b$d ${S[$s]} of space was cleaned up"
}

oldAvailable=$(df / | tail -1 | awk '{print $4}')

# Ask for the administrator password upfront
sudo -v

applications=(
'/Library/Widgets/*'
'/Sytem/Library/WidgetResources/*'
'/Applications/Font\ Book.app'
'/Library/Desktop\ Pictures/*'
'/Library/Screen\ Savers/Default\ Collections/*'
'/Applications/Game Center.app'
'/Applications/Stickies.app'
'/Applications/Stickies.app'
'/Applications/Utilities/Audio Midi Setup.app'
'/Applications/Utilities/Boot Camp Assistant.app'
'/Applications/Utilities/Migration Assistant.app'
'/System/Library/CoreServices/Photo Library Migration Utility.app'
)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/elvismercado/development-environment/master/.uninstallers-mac/garageband.sh)"
rm -rvf ${applications[@]}

newAvailable=$(df / | tail -1 | awk '{print $4}')
count=$((oldAvailable - newAvailable))

bytesToHuman $count
