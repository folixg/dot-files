#!/usr/bin/env bash

# dependencies
# - i3 : metapackage (i3 window manager, screen locker, menu, statusbar)
# - i3blocks : used as i3bar status command
# - feh : used to show custom background image
# - xautolock: lock inactive session
# - scrot: screenshot tool for fancy lock screen
# - playerctl: mpris control for media players
#
# fonts
# - Source Code Pro
# - FontAwesome

# install everything that's available through apt
packets="i3 i3blocks feh xautolock scrot"
sudo apt-get install -y $packets

# install playerctl
wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb
sudo dpkg -i playerctl-0.5.0_amd64.deb
rm playerctl-0.5.0_amd64.deb

#install fonts in user home
if [ "$(fc-list | grep -c "Source Code Pro")" == "0" ]; then
  install_scp="1"
else
  install_scp="0"
fi
if [ "$(fc-list | grep -c "FontAwesome")" == "0" ]; then
  install_fa="1"
else
  install_fa="0"
fi
if [[ $install_scp == "1" || $install_fa == "1" ]] ; then
  current_dir=$PWD
  # create user font dir, if it does not exist
  if [ ! -d ~/.fonts ]; then
    mkdir ~/.fonts
  fi
  cd ~/.fonts || exit
  # install Source Code Pro
  if [ $install_scp == "1" ] ; then
    wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz
    tar xvf 1.050R-it.tar.gz
    rm 1.050R-it.tar.gz
  fi
  # install FontAwesome
  if [ $install_fa == "1" ] ; then
    git clone https://github.com/FortAwesome/Font-Awesome.git ~/.fonts/fa
  fi
  # update font cache
  fc-cache -f ~/.fonts
  cd "$current_dir" || exit
fi
# link config files
if [ ! -d ~/.i3 ]; then
  mkdir ~/.i3
fi
if [ -e ~/.i3/config ] ; then
  mv ~/.i3/config ~/.i3/config_old
fi
ln -s "$PWD"/config ~/.i3/config
if [ -e ~/.i3/i3blocks.conf ] ; then
  mv ~/.i3/i3blocks.conf ~/.i3/i3blocks.conf_old
fi
ln -s "$PWD"/i3blocks.conf ~/.i3/i3blocks.conf
if [ -e ~/.i3/lock ] ; then
  mv ~/.i3/lock ~/.i3/lock_old
fi
ln -s "$PWD"/lock ~/.i3/
# link custom blocklet folder
if [ -e ~/.i3/blocklets ] ; then
  mv ~/.i3/blocklets ~/.i3/blocklets_old
fi
ln -s "$PWD"/blocklets ~/.i3/blocklets
