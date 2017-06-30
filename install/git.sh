#!/usr/bin/env bash
mode=$1

if ! [ \( $mode = "private" \) -o \( $mode = "work" \)   ]; then
    echo "Usage: ./setup.sh [private | work]"
else
    if [ -e ~/.gitconfig ]; then
      mv ~/.gitconfig ~/.gitconfig_old
    fi
    if [ $mode = "private" ]; then
      ln -s $PWD/private.gitconfig ~/.gitconfig
    else
      ln -s $PWD/work.gitconfig ~/.gitconfig
    fi
    if [ -e ~/.gitignore ]; then
      mv ~/.gitignore ~/.gitignore_old
    fi
      ln -s $PWD/global.gitignore ~/.gitignore
fi
