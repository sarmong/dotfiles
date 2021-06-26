# If not running interactively, don't do anything
[[ $- == *i* ]] || return

[ -n "$PS1" ] && source ~/.bash_profile;

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export _JAVA_AWT_WM_NONREPARENTING=1
export PATH=$HOME/.config/nvcode/utils/bin:$PATH
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

export RUSTUP_HOME=$XDG_CONFIG_HOME/rust/rustup
export CARGO_HOME=$XDG_CONFIG_HOME/rust/cargo
source "/home//.config/rust/cargo/env"
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
