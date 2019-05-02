# Include user dirs in PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Set vim as default editor
export EDITOR=vim

# Path to dot-files repository
export DOTFILES=$HOME/dot-files

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

