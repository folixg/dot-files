# navigation with dirstack
alias d='dirs -v'
alias 1='cd ~1'
alias 2='cd ~2'
alias 3='cd ~3'
alias 4='cd ~4'
alias 5='cd ~5'
alias 6='cd ~6'
alias 7='cd ~7'
alias 8='cd ~8'
alias 9='cd ~9'

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

# alias for ubuntu docker
alias ubuntu='docker pull folixg/ubuntu:latest && \
              docker run --rm -it -e USER_UID=$UID -e USER_GID=$GID \
              -v `pwd`:/home/folix/workspace folixg/ubuntu' 

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
