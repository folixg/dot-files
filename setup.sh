#!/usr/bin/env bash

# Turn a clean installation into my customized setup
# Tested with xubuntu 16.04
#
# --noroot : skip all steps that use sudo
# --headless : don't install/configure stuff that needs a X server

noroot="False"
headless="False"

for i in "$@"
do
  case $i in
    "--noroot" )
      noroot="True"
    ;;
    "--headless" )
      headless="True"
    ;;
    * )
      echo "Possible options are:"
      echo " --noroot : skip all steps that use sudo"
      echo " --headless : don't install/configure stuff that needs a X server"
      exit
    ;;
  esac
done

# if we have sudo rights, install some additional packets
if [ "$noroot" == "False" ] ; then
  echo "### installing additional packages ###"
  # packages to install
  packages="vim curl zsh golang atom python3-pip shellcheck"
  # add atom ppa
  sudo add-apt-repository -y ppa:webupd8team/atom
  sudo apt-get update
  # install packets
  sudo apt-get install -y $packages
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
  echo "### linkking ~./Xresources ###"
  cd ..
  if [ -e ~/.Xresources ] ; then
    mv ~/.Xresources ~/.Xresources.old
  fi
  ln -s "$PWD/Xresources" ~/.Xresources
  # setup atom
  echo "### setting up atom ###"
  git clone https://github.com/folixg/setup-atom-sync.git atom-sync
  cd atom-sync
  ./setup_atom_sync.sh
  cd ..
  # install Source Code Pro font
  echo "### installing Source Code Pro font ###"
  # ~/.fonts was already created by i3 setup
  cd ~/.fonts
  wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz
  tar xvf 1.050R-it.tar.gz
  rm 1.050R-it.tar.gz
  fc-cache -v -f .
fi
