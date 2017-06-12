#!/usr/bin/env bash

# dependencies
# - i3 : metapackage (i3 window manager, screen locker, menu, statusbar) 
# - i3blocks : used as i3bar status command
# - feh : used to show custom background image
# - xautolock: lock inactive session
# - scrot: screenshot tool for fancy lock screen
# - playerctl: mpris control for media players

# install everything that's available through apt
packets="i3 i3blocks feh xautolock scrot"
sudo apt-get install -y $packets

# install playerctl
wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb
sudo dpkg -i playerctl-0.5.0_amd64.deb
rm playerctl-0.5.0_amd64.deb

#install Font Awesome in user home
if [ ! -d ~/.fonts ]; then
  mkdir ~/.fonts
fi
git clone https://github.com/FortAwesome/Font-Awesome.git ~/.fonts/fa
fc-cache -f -v .fonts/fa

# link config files
if [ ! -d ~/.i3 ]; then
  mkdir ~/.i3
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
