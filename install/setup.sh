#!/usr/bin/env bash

__link_dotfile() {
  if [ -e ~/."$1" ] ; then             
    mv "$HOME/.$1" "$HOME/.$1_old" || exit 1
  fi
  ln -sf "$DOTFILES/$1" "$HOME/.$1" || exit 1
}

# get base directory
DOTFILES=$(cd "${0%/*}" && pwd)
DOTFILES="${DOTFILES%/install}"
cd "$DOTFILES"

# create bin directory in user home
if ! [ -d ~/bin ] ; then
  mkdir ~/bin || exit 1
  echo "### created ~/bin directory ###"
fi

# link ~/.bash_aliases
echo "### linking bash_aliases ###"
__link_dotfile "bash_aliases"
# link ~/.bashrc
echo "### linking bashrc ###"
__link_dotfile "bashrc"
# link ~/.profile
echo "### linking profile ###"
__link_dotfile "profile"
# configure zsh
if [ "$(which zsh)" ] ; then
  echo "### setting up zsh ###"
  echo "### linking zshrc ###"
  __link_dotfile "zshrc"
  echo "### linking zshenv ###"
  __link_dotfile "zshenv"
  echo "### zsh setup done ###"
fi

# install fzf
echo "### installing fzf ###"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-fish --all

# link gitconfig
echo "### linking global gitignore ###"
__link_dotfile "gitignore" || exit 1
echo "### linking gitconfig ###"
__link_dotfile "gitconfig" || exit 1

# vim setup
echo "### linking vimrc ###"
__link_dotfile "vimrc" || exit 1
echo "### linking gvimrc ###"
__link_dotfile "gvimrc" || exit 1
echo "### linking vim config folder ###"
__link_dotfile "vim" || exit 1
echo "### fetching pathogen plugins ###"
git submodule init
git submodule update
__link_dotfile "ctags" || exit 1
echo "### linking ctags config ###"

# gpg setup
if [ ! -d "$HOME"/.gnupg ]; then
  mkdir "$HOME"/.gnupg || exit 1
  echo "### created new folder '~/.gnupg' ###"
fi
echo "### setting permissions for '~/.gnupg' (0700) ###"
# chmod 0700 "$HOME"/.gnupg || exit 1
echo "### setting persmissions for gpg config files (0600) ###"
chmod 0600 "$DOTFILES"/gnupg/dirmngr.conf
chmod 0600 "$DOTFILES"/gnupg/gpg.conf
chmod 0600 "$DOTFILES"/gnupg/gpg-agent.conf
chmod 0600 "$DOTFILES"/gnupg/sshcontrol
echo "### linking ~/.gnupg/dirmng.conf ###"
__link_dotfile "gnupg/dirmngr.conf"
echo "### linking ~/.gnupg/gpg.conf ###"
__link_dotfile "gnupg/gpg.conf"
echo "### linking ~/.gnupg/gpg-agent.conf ###"
__link_dotfile "gnupg/gpg-agent.conf"
echo "### linking ~/.gnupg/sshcontrol ###"
__link_dotfile "gnupg/sshcontrol"
echo "### linking ~/.ssh/config ###"
__link_dotfile "ssh/config"
echo "### fetching public key from keyserver ###"
if [ "$(which gpg2)" ]; then
  gpg2 --recv-key 0x1782EA931CF39ED8
else
  gpg --recv-key 0x1782EA931CF39ED8
fi

# install Source Code Pro
FONT_DIR="$HOME"/.local/share/fonts
# create user font dir, if it does not exist
if [ ! -d "$FONT_DIR" ] ; then
  mkdir "$FONT_DIR" || exit 1
  echo "### created fonts folder $FONT_DIR ###"
fi
if [ "$(fc-list | grep -c "Source Code Pro")" == "0" ] ; then
  echo "### installing Source Code Pro font ###"
  wget -P "$FONT_DIR" https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz || exit 1
  tar xvf "$FONT_DIR"/1.050R-it.tar.gz -C "$FONT_DIR" || exit 1
    rm "$FONT_DIR"/1.050R-it.tar.gz || exit 1
fi
# update font cache
echo "### updating font cache ###"
fc-cache -f "$FONT_DIR" || exit 1

# link Xrescoures
echo "### linking ~/.Xresources ###"
__link_dotfile "Xresources"

# link tmux config 
echo "### linking ~/.tmux.conf ###"
__link_dotfile "tmux.conf"

# link VS Code config
echo "### linking ~/.config/Code/User/settings.json ###"
if [ ! -d "$HOME/.config" ] ; then
  mkdir "$HOME/.config" || exit 1
fi
if [ ! -d "$HOME/.config/Code" ] ; then
  mkdir "$HOME/.config/Code" || exit 1
fi
if [ ! -d "$HOME/.config/Code/User" ] ; then
  mkdir "$HOME/.config/Code/User" || exit 1
fi
__link_dotfile "config/Code/User/settings.json"


echo "### setup done ###"
