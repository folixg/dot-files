#If you come from bash you might have to change your $PATH.
 export PATH=$PATH:$HOME/bin

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Path to dot-files repository
  export DOTFILES=$HOME/dot-files

# Use vim as default editor
  export EDITOR=vim
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="fromscratch"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo golang fasd cargo)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# safety measure for gpg-agent, as recommended by gpg-agent manual
GPG_TTY=$(tty)
export GPG_TTY

if [[ $UID -ne 0 ]]; then
  # use gpg-agent instead of ssh-agent (if there is a private auth key available)
  if [[ $( gpg2 -K | grep "\[A\]" ) ]] ; then
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
    fi
  # otherwise start ssh-agent and add ssh key
  else
    eval $(ssh-agent) 1>/dev/null
    ssh-add 1>/dev/null
  fi
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Try to launch tmux per default over ssh
ssh() {
  /usr/bin/ssh -t $@ "tmux new || zsh || bash";
}

# helper functions for gpg
gpg-key-lock() {
  pid=$(pgrep gpg-agent)
  if [ "$pid" ] ; then
    kill -SIGHUP "$pid"
  fi
}

gpg-key-unlock() {
  echo "" | gpg2 -s &>/dev/null
}

gpg-focus() {
  pid=$(pgrep pinentry-curses)
  if [ "$pid" ] ; then
    kill "$pid"
  fi
  echo "UPDATESTARTUPTTY" | gpg-connect-agent 1>/dev/null
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
if [ -d /nfs/tools ] ; then
  source /nfs/tools/environment_modules/3.2.8/init/zsh
fi

source $DOTFILES/scripts/last_output_tab_list.zsh

# open MS word documents in vim
docx2vim() {
  pandoc -f docx -t markdown "$1" | vim -c ":set filetype=markdown" -
}
