#!/usr/bin/env bash
if [  -d ~/.vim ]; then
  mv ~/.vim ~/.vim_old
  echo "Created backup of existing '~/.vim' folder."
fi
if [ -e ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc_old
  echo "Created backup of existing '~/.vimrc'."
fi
echo "Installing pathogen plugins."
git submodule init
git submodule update
echo "Replacing config files with links to repository."
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vim ~/.vim
