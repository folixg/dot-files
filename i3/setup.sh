#!/usr/bin/env bash

# dependencies
# - i3blocks : used as irbar status command
# - feh : used to show custom background image
# - xautolock: lock inactive session
# - scrot: screenshot tool for fancy lock screen
# - playerctl: mpris control for media players
declare -a deps=("i3blocks" "feh" "xautolock" "scrot" "playerctl")

for tool in "${deps[@]}"
do
  if ! [[ -x "$(command -v $tool)" ]]; then
    echo "$tool not found, trying to install it."
    if [ "$tool" != playerctl ]; then
      sudo apt-get install $tool
    else
      echo "Please head over to https://github.com/acrisci/playerctl/releases/latest and install playerctl"
    fi
  fi
done

if [ ! -d ~/.i3 ]; then
  mkdir ~/.i3
  echo "Created new folder '~/.i3'."
fi
if [ -e ~/.i3/config ]; then
  mv ~/.i3/config ~/.i3/config_old
fi
ln -s $PWD/config ~/.i3/config
if [ -e ~/.i3/i3blocks.conf ]; then
  mv ~/.i3/i3blocks.conf ~/.i3/i3blocks.conf_old
fi
ln -s $PWD/i3blocks.conf ~/.i3/i3blocks.conf
ln -s $PWD/lock ~/.i3/
