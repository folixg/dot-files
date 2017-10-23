# color grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use GPG2 by default
alias gpg=gpg2

# helpers for gpg
alias lock-gpg-key=$DOTFILES/scripts/lock-gpg-key.sh
alias unlock-gpg-key=$DOTFILES/scripts/unlock-gpg-key.sh
alias gpg-focus=$DOTFILES/scripts/gpg-focus.sh

# alias for ubuntu docker
alias ubuntu='docker run --rm -it -v `pwd`:/data folixg/ubuntu' 

# (dis-)connect eduroam (needs config from https://cat.eduroam.de)
alias eduroam-connect='nmcli connection up eduroam ifname wlp3s0'
alias eduroam-disconnect='nmcli connection down eduroam'

# start vim with servername
alias vim='vim --servername vim'

# lislab
alias lislab='source /nfs/labs/scripts/lislab'
