# ls aliases
if [ "$(uname)" = "Darwin" ] ; then
  export LSCOLORS=ExFxBxDxCxegedabagacad
  alias ls='ls -GFh'
  alias ll='ls -l'
  alias la='ls -a'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

# color grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use GPG2 by default
if which gpg2 &>/dev/null; then
  alias gpg=gpg2
fi

# alias for ubuntu docker
alias ubuntu='docker pull folixg/ubuntu:latest && docker run --rm -it -v `pwd`:/data folixg/ubuntu' 

# (dis-)connect eduroam (needs config from https://cat.eduroam.de)
alias eduroam-connect='nmcli connection up eduroam ifname wlp3s0'
alias eduroam-disconnect='nmcli connection down eduroam'

# start vim with servername (if the vim installation supports it)
# use macvim on mac
if [ "$(uname)" = "Darwin" ] ; then
  alias vim='mvim -v --servername vim'
elif [ "$(vim --version | grep +clientserver)" ] ; then
  alias vim='vim --servername vim'
fi

# use only one gvim instance
alias gvim='gvim --remote-silent'

# git (from oh-my-zsh git plugin)
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcb='git checkout -b'
alias gcl='git clone --recursive'
alias gclean='git clean -fd'
alias gco='git checkout'
alias gd='git diff'
alias gk='gitk --all --branches'
alias gl='git pull'
alias glo='git log --oneline --decorate'
alias gp='git push'
alias grh='git reset HEAD'
alias gss='git status -sb'
alias gst='git status'
alias gsu='git submodule update'
