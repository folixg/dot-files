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

# use gimme to install latest stable version of golang
echo "### installing gimme ###"
curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme || exit 1
chmod +x ~/bin/gimme || exit 1
echo "### installing go ###"
eval "$(gimme stable)" || exit 1

# link ~/.bash_aliases
echo "### linking bash_aliases ###"
__link_dotfile "bash_aliases"

# configure zsh
if ! [ "$(which zsh)" ] ; then
  echo "### zsh not found, setting up bash ###"
  __link_dotfile "bashrc"
else
  echo "### setting up zsh ###"
  # install oh-my-zsh
  echo "### cloning oh-my-zsh ###"
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh || exit 1
  # replace oh-my-zsh .zshrc with link to this repository
  echo "### linking zshrc ###"
  __link_dotfile "zshrc"
  # install custom gimme oh-my-zsh plugin
  echo "### installing custom ohmyzsh plugin gimme ###"
  git clone https://github.com/folixg/gimme-ohmyzsh-plugin.git ~/.oh-my-zsh/custom/plugins/gimme || exit 1
  # link fasd to ~/bin
  echo "### linking fasd to ~/bin ###"
  ln -sf "$DOTFILES"/scripts/fasd "$HOME"/bin/fasd || exit 1
  # link to minimal .bashrc to launch zsh as default if chsh failed
  loginshell=$(getent passwd "$LOGNAME" | cut -d: -f7)
  if ! [ "${loginshell##*/}" == "zsh" ] ; then
    echo "### zsh is not default shell, linking to bashrc, that starts zsh ###"
    if [ -f "$HOME"/.bashrc ] ; then
      mv "$HOME"/.bashrc "$HOME"/.bashrc_prezsh || exit 1
    fi
    ln -sf "$DOTFILES"/zsh.bashrc "$HOME"/.bashrc || exit 1
  fi
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
  git clone https://github.com/FortAwesome/Font-Awesome.git "$FONT_DIR"/fa || exit 1
fi
# update font cache
echo "### updating font cache ###"
fc-cache -f "$FONT_DIR" || exit 1

# link Xrescoures
echo "### linking ~/.Xresources ###"
__link_dotfile "Xresources"

echo "### setup done ###"
