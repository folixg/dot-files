#!/usr/bin/env fish

set -U fish_greeting

set -x EDITOR vim
set -U fish_key_bindings fish_hybrid_key_bindings

set -x PATH ~/bin ~/.local/bin /usr/local/go/bin ~/go/bin ~/gems/bin $PATH

# syntax highlighting with less
if type -pq highlight
set -x LESSOPEN "|highlight --quiet --force --line-numbers --line-length=80 --wrap-no-numbers --out-format=xterm256 --style=xoria256 %s"
set -x LESS ' -R'
end

set -x GPG_TTY (tty)

# use gpg for authentication
if type -pq gpg2
  set gpg_bin gpg2
else
  set gpg_bin gpg
end

set auth_key ($gpg_bin -K | grep "\[A\]")

if test -n $auth_key
  gpgconf --launch gpg-agent
  set -e SSH_AUTH_SOCK
  set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
else
  eval (ssh-agent -c)
  ssh-add
end

# use ripgrep with fzf
set -x FZF_CTRL_T_COMMAND 'rg --files --hidden'

