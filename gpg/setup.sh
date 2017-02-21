#!/usr/bin/env bash
echo "Replacing config files with links to repository."
if [ -e ~/.gnupg/dirmngr.conf ]; then
  mv ~/.gnupg/dirmngr.conf ~/.gnupg/dirmngr.conf_old
fi
ln -s $PWD/dirmngr.conf ~/.gnupg/dirmngr.conf
if [ -e ~/.gnupg/gpg.conf ]; then
  mv ~/.gnupg/gpg.conf ~/.gnupg/gpg.conf_old
fi
ln -s $PWD/gpg.conf ~/.gnupg/gpg.conf
if [ -e ~/.gnupg/gpg-agent.conf ]; then
  mv ~/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf_old
fi
ln -s $PWD/gpg-agent.conf ~/.gnupg/gpg-agent.conf
echo "Fetching public key from keyserver."
gpg2 --recv-key 0x1782EA931CF39ED8
