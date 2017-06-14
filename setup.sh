#!/usr/bin/env bash

# Turn a clean installation into my customized setup
# Tested with xubuntu 16.04
#
# --noroot : skip all steps that use root privileges
# --headless : don't install/configure stuff that needs a X server
# --atom : install and set up atom editor

noroot="False"
headless="False"
atom="False"

for i in "$@"
do
  case $i in
    "--noroot" )
      noroot="True"
    ;;
    "--headless" )
      headless="True"
    ;;
    "--atom" )
      atom="True"
    ;;
    * )
      echo "Possible options are:"
      echo " --noroot : skip all steps that use root privileges"
      echo " --headless : don't install/configure stuff that needs a X server"
      echo " --atom : install and setup atom (can not be mixed with other options)"
      exit
    ;;
  esac
done

# if we have root privileges, install some additional packets
if [ "$noroot" == "False" ] ; then
  # check whether we are root, or we need to use sudo
  if [ "$(id -u)" == "0" ] ; then
    sudo_prefix=""
  else
    sudo_prefix="sudo"
  fi
  echo "### installing additional packages ###"
  # packages to install
  packages="vim curl wget zsh gnupg2 python3-pip shellcheck"
  # install packets
  "$sudo_prefix apt-get install -y $packages"
  # install golang manually to get 1.8 instead of apts 1.6
  wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
  $sudo_prefix tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz
  rm go1.8.3.linux-amd64.tar.gz
fi
# install python linter flake8
if [ "$(which pip3)" ]; then
  echo "### installing flake8 ###"
  pip3 install flake8
fi
# setup zsh
if ! [ "$(which zsh)" ]; then
  echo "### zsh not found, setting up bash ###"
  cd bash
  ./setup.sh
else
  echo "### setting up zsh ###"
  cd zsh
  ./setup.sh
fi
# setup vim
echo "### setting up vim ###"
cd ../vim
./setup.sh
# setup gpg
echo "### setting up gpg ###"
cd ../gpg
./setup.sh
# setup git
echo "### setting up git ###"
cd ../git
./setup.sh private

if [ "$headless" == "False" ] ; then
  # setup i3
  if [ "$noroot" == "True" ]; then
    echo "### skipping i3 setup, because of --noroot ###"
  else
    echo "### installing and setting up i3 ###"
    cd ../i3
    ./setup.sh
  fi
  # link Xresources
  echo "### linking ~./Xresources ###"
  cd ..
  if [ -e ~/.Xresources ] ; then
    mv ~/.Xresources ~/.Xresources.old
  fi
  ln -s "$PWD/Xresources" ~/.Xresources
  # install Source Code Pro font
  echo "### installing Source Code Pro font ###"
  # ~/.fonts was already created by i3 setup
  cd ~/.fonts
  wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz
  tar xvf 1.050R-it.tar.gz
  rm 1.050R-it.tar.gz
  fc-cache -v -f .
fi
# install and set up atom
if [ "$atom" == "True" ] ; then
  if [ "$headless" == "True" ] || [ "$noroot" == "True" ] ; then
    echo "### not installing atom because of --headless or --noroot switch ###"
    exit
  fi
  # add atom ppa
  echo "### adding atom ppa ###"
  $sudo_prefix add-apt-repository -y ppa:webupd8team/atom
  $sudo_prefix apt-get update
  # install atom
  echo "### installing atom ###"
  $sudo_prefix apt-get install -y atom
  echo "### setting up atom-sync ###"
  git clone https://github.com/folixg/setup-atom-sync.git ~/atom-sync
  cd ~/atom-sync
  ./setup_atom_sync.sh
fi
