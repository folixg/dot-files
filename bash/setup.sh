#!/usr/bin/env bash
if [ -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc_old
fi
ln -s $PWD/bashrc ~/.bashrc
if [ -e ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases_old
fi
ln -s $PWD/bash_aliases ~/.bash_aliases
