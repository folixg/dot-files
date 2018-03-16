#!/usr/bin/env bash
# This script customizes an installation  as far as it is possible without root
# If you have root privileges, use ansible for the installation.


__link_dotfile() {
  if [ -e ~/."$1" ] ; then             
    mv "$HOME/.$1" "$HOME/.$1_old" || exit 1
  fi
  ln -sf "$DOTFILES/$1" "$HOME/.$1" || exit 1
}

# check if dot-files location is set
if [ "$DOTFILES" == "" ] ; then
  echo "Location of dot-files respository not set.
  Either export it e.g. 'export DOTFILES=~/dot-files'
  Or set it when calling this script e.g. 'DOTFILES=~/dot-files ./setup.sh'"
  exit 1
else
  echo "### Installing using the dotfiles located in $DOTFILES ###"
fi

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
  # install oh-my-zsh
  if ! [ -d ~/.oh-my-zsh ] ; then
  echo "### cloning oh-my-zsh ###"
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh || exit 1
  fi
  # replace oh-my-zsh .zshrc with link to this repository
  echo "### linking zshrc ###"
  __link_dotfile "zshrc"
  # install custom oh-my-zsh theme
  echo "### installing custom ohmyzsh theme ###"
  if ! [ -d ~/.oh-my-zsh/custom/themes ] ; then
    mkdir ~/.oh-my-zsh/custom/themes || exit 1
  fi
  curl -sL -o ~/.oh-my-zsh/custom/themes/kinda-fishy.zsh-theme https://raw.githubusercontent.com/folixg/kinda-fishy-theme/master/kinda-fishy.zsh-theme || exit 1
  # link fasd to ~/bin
  echo "### download fasd to ~/bin ###"
  curl -sL -o ~/bin/fasd https://raw.githubusercontent.com/clvv/fasd/master/fasd || exit 1
  chmod +x ~/bin/fasd || exit 1
  echo "### zsh setup done ###"
fi

# link gitconfig
echo "### linking global gitignore ###"
__link_dotfile "gitignore" || exit 1
echo "### linking gitconfig ###"
__link_dotfile "gitconfig" || exit 1

# vim setup
echo "### linking vimrc ###"
__link_dotfile "vimrc" || exit 1
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
chmod 0700 "$HOME"/.gnupg || exit 1
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
echo "### fetching public key from keyserver ###"
gpg2 --recv-key 0x1782EA931CF39ED8

# i3 setup
echo "### linking i3 config folder ###"
__link_dotfile "i3"

# font installation
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
# install FontAwesome
if [ "$(fc-list | grep -c "FontAwesome")" == "0" ] ; then
  echo "### installing Font Awesome font ###"
  wget -P "$FONT_DIR" https://github.com/FortAwesome/Font-Awesome/archive/v4.7.0.tar.gz || exit 1
  tar xvf "$FONT_DIR"/v4.7.0.tar.gz -C "$FONT_DIR" || exit 1
  rm "$FONT_DIR"/v4.7.0.tar.gz || exit 1
fi
# update font cache
echo "### updating font cache ###"
fc-cache -f "$FONT_DIR" || exit 1

# link Xrescoures
echo "### linking ~/.Xresources ###"
__link_dotfile "Xresources"

# link Zathura config
ZATHURA_CONF_DIR="$HOME/.config/zathura"
echo "### linking ~/.config/zathura/zathurarc ###"
if [ ! -d "$ZATHURA_CONF_DIR" ] ; then
  mkdir "$ZATHURA_CONF_DIR" || exit 1;
fi
if [ -e "$ZATHURA_CONF_DIR/zathurarc" ] ; then
  mv "$ZATHURA_CONF_DIR/zathurarc" "$ZATHURA_CONF_DIR/zathurarc.old" || exit 1 
fi
ln -sf "$DOTFILES/zathurarc" "$ZATHURA_CONF_DIR/zathurarc" || exit 1

# link tmux config 
echo "### linking ~/.tmux.conf ###"
__link_dotfile "tmux.conf"

echo "### setup done ###"
