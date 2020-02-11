# Custom functions
fpath=($DOTFILES/zsh-functions $fpath)
autoload -Uz docx2vim gpg-key-lock gpg-key-unlock ssh view-html
autoload -Uz _pip_completion _jh-prev-result

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Change directory when only path is given
setopt autocd

# Use directory stack
setopt autopushd pushdminus pushdsilent pushdtohome pushd_ignore_dups
DIRSTACKSIZE=10

# Additional pattern matching
setopt extendedglob

# Correct typos
setopt correct

# Don't beep
unsetopt beep

# Use vi keybindings
bindkey -v

# Basic completion settings
zstyle ':completion:*' menu select
zstyle :compinstall filename ~/.zshrc

# Complete case and hyphen insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use additional zsh-completions
if [ -d $DOTFILES/zsh-completions/src/ ] ; then
  fpath=($DOTFILES/zsh-completions/src $fpath)
fi
compctl -K _pip_completion pip
compctl -K _pip_completion pip3

# Load completion system (-i to ignore insecure files and directories)
autoload -Uz compinit
compinit -i

# Enable color support
autoload -Uz colors
colors

# Use custom prompt
autoload -Uz promptinit
promptinit
setopt prompt_subst
prompt folix

# ring bell when long running commands finish
# https://gist.github.com/jpouellet/5278239
autoload -Uz zbell
zbell

# identify special keys
typeset -A key
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}

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

# Use alt-n or esc-n to tab-select through the output of a previous
# command.
# Use-case: ls or find was the previous command, and you now want to
# edit one of them. No need for mouse copy-pasta.
#
# https://www.zsh.org/mla/users/2004/msg00893.html
zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '\en' jh-prev-comp

# use ctrl+Space to expand aliases in insert mode
bindkey -M viins '^ '        _expand_alias

# xterm title
autoload -Uz add-zsh-hook
if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
	add-zsh-hook -Uz precmd _xterm_title_precmd
	add-zsh-hook -Uz preexec _xterm_title_preexec
fi

# Safety measure for gpg-agent, as recommended by gpg-agent manual
GPG_TTY=$(tty)
export GPG_TTY

# GPG for authentication
if [ -f /usr/bin/gpg2 ]; then
  GPG_BIN=/usr/bin/gpg2
else
  GPG_BIN=/usr/bin/gpg
fi
if [[ $UID -ne 0 ]]; then
  # Use gpg-agent instead of ssh-agent (if there is a private auth key available)
  if [[ $( "$GPG_BIN" -K 2>/dev/null | grep "\[A\]" ) ]] ; then
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

# Alias file
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# set LS_COLORS
if (which dircolors &> /dev/null); then
  eval "$(dircolors $DOTFILES/dircolors)"
fi

# syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=blue,bg=black'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=blue,bg=black'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source "$DOTFILES"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
