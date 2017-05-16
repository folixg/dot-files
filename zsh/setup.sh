#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# replace oh-my-zsh .zshrc with link to this repository
rm $HOME/.zshrc
ln -s $PWD/zshrc $HOME/.zshrc

# if there is no ~/.bash_aliases, link to the one from the repository
if [ ! -f $HOME/.bash_aliases ]; then
  ln -s ../bash/bash_aliases $HOME/.bash_aliases
fi

# link to minimal .bashrc to launch zsh as default if chsh failed
if [ -f $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc_prezsh
fi
ln -s $PWD/bashrc $HOME/.bashrc
