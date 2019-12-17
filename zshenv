# Include user dirs in PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Set vim as default editor
export EDITOR=vim

# Path to dot-files repository
export DOTFILES=$HOME/dot-files

# Use ripgrep with fzf file selection keybinding
if (which rg &> /dev/null); then
  export FZF_CTRL_T_COMMAND='rg --files --hidden'
fi

# Colorscheme for fzf
export FZF_DEFAULT_OPTS='
--color=dark
--color=fg:-1,bg:-1,hl:#50fa7b,fg+:-1,bg+:#44475a,hl+:#50fa7b
--color=info:#6272a4,prompt:#f8f8f2,pointer:#f8f8f2,marker:#ffb86c,spinner:#6272a4
'

# syntax highlighting with less
if (which highlight &> /dev/null); then
  export LESSOPEN="|highlight --quiet --force --line-numbers --line-length=80 --wrap-no-numbers --out-format=xterm256 --style=xoria256 %s"
  export LESS=' -R'
fi

# Go
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$PATH:$GOPATH/bin"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# Install Ruby gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

# # Load LIS environment settings
# if [ -r /etc/bash.bashrc.d/10-lis ] ; then
#   source /etc/bash.bashrc.d/10-lis
# fi

# # Support for LIS module system
# if [ -r /nfs/tools/environment_modules/ ] ; then
#   source /nfs/tools/environment_modules/3.2.8/init/zsh
# fi

