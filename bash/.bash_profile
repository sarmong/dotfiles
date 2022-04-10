#!/usr/bin/env bash

## ~/ cleanup
## See wiki for details - https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_DATA_HOME="$HOME/.local/share"
source "$XDG_CONFIG_HOME/user-dirs.dirs"

export LESSHISTFILE="-" # removes lesshist file
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrs"
export INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

export PATH="$XDG_BIN_DIR:$PATH"
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=1000000
export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER=firefox
export PAGER=less
export QT_QPA_PLATFORMTHEME="qt5ct" # required by qt5ct

# Fixes issues with Java application(Webstorm) in tiling WM
export _JAVA_AWT_WM_NONREPARENTING=1

## Set custom MANPAGER
# fixes formatting issues
export MANROFFOPT="-c"
# bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## ==================== ##
## Programming settings ##
## ==================== ##

# NVM settings
# ============
## Might need for Ubuntu
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

[ -s "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh

# https://stackoverflow.com/questions/23556330/run-nvm-use-automatically-every-time-theres-a-nvmrc-file-on-the-directory
# Run 'nvm use' automatically every time there's
# a .nvmrc file in the directory. Also, revert to default
# version when entering a directory without .nvmrc
enter_directory() {
  if [[ $PWD == "$PREV_PWD" ]]; then
    return
  fi

  PREV_PWD=$PWD
  if [[ -f ".nvmrc" ]]; then
    nvm use
    NVM_DIRTY=true
  elif [[ $NVM_DIRTY = true ]]; then
    nvm use system
    NVM_DIRTY=false
  fi
}

export PROMPT_COMMAND=enter_directory

if command -v mkcert &>/dev/null; then
  export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
fi

# Rust
# ===============

export RUSTUP_HOME=$XDG_CONFIG_HOME/rust/rustup
export CARGO_HOME=$XDG_CONFIG_HOME/rust/cargo

export PATH="$HOME/.cargo/bin:$PATH"
[ -f "$XDG_CONFIG_HOME/rust/cargo/env" ] && source "$XDG_CONFIG_HOME/rust/cargo/env"

# ============
# ============

if [[ "$(uname)" != "Darwin" ]] && [[ -s "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ "$(uname)" == "Darwin" ]; then
  source "$HOME/.bashrc"
fi

if [ -n "$BASH_VERSION" ] && [ -n "$PS1" ] && [ -z $BASHRC_LOADED ]; then
  source "$HOME/.bashrc"
fi
