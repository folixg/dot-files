# color grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use GPG2 by default
alias gpg=gpg2

# alias for ubuntu docker
alias ubuntu='docker pull folixg/ubuntu:latest && docker run --rm -it -v `pwd`:/data folixg/ubuntu' 

# (dis-)connect eduroam (needs config from https://cat.eduroam.de)
alias eduroam-connect='nmcli connection up eduroam ifname wlp3s0'
alias eduroam-disconnect='nmcli connection down eduroam'

# start vim with servername (doesn't work on mac)
if [ "$(uname)" != "Darwin" ] ; then
  alias vim='vim --servername vim'
fi

# lislab
alias lislab='source /nfs/labs/scripts/lislab'
