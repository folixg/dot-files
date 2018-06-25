# Include user dirs in PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Set vim as default editor
export EDITOR=vim

# Path to dot-files repository
export DOTFILES=$HOME/dot-files

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Change directory when only path is given
setopt autocd

# Additional pattern matching
setopt extendedglob

# Don't beep
unsetopt beep

# Use vi keybindings
bindkey -v

# Basic completion settings
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/no56way/.zshrc'

# Use additional zsh-completions
if [ -d $DOTFILES/zsh-completions/src/ ] ; then
  fpath=($DOTFILES/zsh-completions/src $fpath)
fi

# Complete case and hyphen insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Completion for pip(3)
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
compctl -K _pip_completion pip3

# Load completion system
autoload -Uz compinit
compinit

# Enable color support
autoload -Uz colors
colors

# Enable vcs_info and configure for git
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "[%b%c%u%m]"
zstyle ':vcs_info:*' unstagedstr "!"
zstyle ':vcs_info:*' stagedstr "+"
precmd() { vcs_info }
setopt prompt_subst

# git: Show marker if there are untracked files in repository
# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        hook_com[misc]+='?'
    fi
}

# Left prompt
USER_HOST=""
[ "$SSH_CLIENT" ] || [ "$(grep docker /proc/1/cgroup 2>/dev/null)" ] && USER_HOST='%n@%m:'
PROMPT='$USER_HOST%(!.%{$fg[red]%}.%{$fg[yellow]%})%~%{$reset_color%}%(!.#.>) '

# vi-mode info for prompt
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg[yellow]%}[% NORMAL]% %{$reset_color%}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Return code for prompt
PROMPT_RETURN_CODE="%(?..%{$fg_bold[red]%}%?%{$reset_color%})"

# Change color for dirty working directory
function git_prompt_color() {
  STATUS=$(git status --porcelain 2>/dev/null)
  if [ "$STATUS" ]; then
    echo "%{$fg[magenta]%}"
  else
    echo "%{$fg[yellow]%}"
  fi
}

# Right prompt with return code, vi-mode info and git info
RPROMPT='$PROMPT_RETURN_CODE ${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_prompt_color)${vcs_info_msg_0_}%{$reset_color%}'

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Cycle through history
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# History search
bindkey '^r' history-incremental-search-backward

# Alias file
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# xterm title
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn '\e]2;%~\a'
}
function xterm_title_preexec () {
	print -Pn '\e]2;%~ %# '
	print -n "${(q)1}\a"
}
if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Safety measure for gpg-agent, as recommended by gpg-agent manual
GPG_TTY=$(tty)
export GPG_TTY

# GPG for authentication
if [[ $UID -ne 0 ]]; then
  # Use gpg-agent instead of ssh-agent (if there is a private auth key available)
  if [[ $( gpg -K | grep "\[A\]" ) ]] ; then
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
    fi
  # Otherwise start ssh-agent and add ssh key
  else
    eval $(ssh-agent) 1>/dev/null
    ssh-add 1>/dev/null
  fi
fi

# Helper functions for gpg
gpg-key-lock() {
  pid=$(pgrep gpg-agent)
  if [ "$pid" ] ; then
    kill -SIGHUP "$pid"
  fi
}
gpg-key-unlock() {
  echo "" | gpg -s &>/dev/null
}
gpg-focus() {
  pid=$(pgrep pinentry-curses)
  if [ "$pid" ] ; then
    kill "$pid"
  fi
  echo "UPDATESTARTUPTTY" | gpg-connect-agent 1>/dev/null
}

# Try to launch tmux per default over ssh
ssh() {
  /usr/bin/ssh -t $@ "tmux new 2>/dev/null || zsh 2>/dev/null || bash";
}

# Go
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$PATH:$GOPATH/bin"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# Load LIS environment settings
if [ -r /etc/bash.bashrc.d/10-lis ] ; then
  source /etc/bash.bashrc.d/10-lis
fi

# Support for LIS module system
if [ -r /nfs/tools/environment_modules/ ] ; then
  source /nfs/tools/environment_modules/3.2.8/init/zsh
fi

# Use alt-n or esc-n to tab-select through the output of a previous
# command.
# Use-case: ls or find was the previous command, and you now want to
# edit one of them. No need for mouse copy-pasta.
#
# https://www.zsh.org/mla/users/2004/msg00893.html
_jh-prev-result () {
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}
zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '\en' jh-prev-comp

# open MS word documents in vim
docx2vim() {
  pandoc -f docx -t markdown "$1" | vim -c ":set filetype=markdown" -
}

# Use fasd
eval "$(fasd --init auto)"
alias v='f -e vim' # quick opening files with vim
alias o='a -e xdg-open' # quick opening files with xdg-open
