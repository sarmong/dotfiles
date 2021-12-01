if [ -d "$HOME/Documents/android/adb-fastboot/platform-tools" ] ; then
 export PATH="$HOME/Documents/android/adb-fastboot/platform-tools:$PATH"
fi

# NVM settings
# ===========
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# https://stackoverflow.com/questions/23556330/run-nvm-use-automatically-every-time-theres-a-nvmrc-file-on-the-directory
# Run 'nvm use' automatically every time there's 
# a .nvmrc file in the directory. Also, revert to default 
# version when entering a directory without .nvmrc

enter_directory() {
    if [[ $PWD == $PREV_PWD ]]; then
        return
    fi

    PREV_PWD=$PWD
    if [[ -f ".nvmrc" ]]; then
        nvm use
        NVM_DIRTY=true
    elif [[ $NVM_DIRTY = true ]]; then
        nvm use default
        NVM_DIRTY=false
    fi
}

export PROMPT_COMMAND=enter_directory

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=~/.config
# export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="$HOME/bin:$PATH:$HOME/.local/bin";
export PATH="/usr/local/sbin:$PATH";
export PATH=$PATH:~/.emacs.d/bin
export INPUTRC=$XDG_CONFIG_HOME/bash/inputrc
export EDITOR="vim";
export HISTCONTROL=ignoreboth:erasedups;
# export HISTCONTROL=ignoreboth:erasedups:ignorespace
export HISTSIZE=100000
export HISTFILESIZE=1000000
export TERMINAL="kitty"
export BROWSER=firefox


# Fixes issues with Java application(Webstorm) in tiling WM
export _JAVA_AWT_WM_NONREPARENTING=1

# Rust
# ===============

export RUSTUP_HOME=$XDG_CONFIG_HOME/rust/rustup
export CARGO_HOME=$XDG_CONFIG_HOME/rust/cargo

export PATH="$HOME/.cargo/bin:$PATH"
source "$XDG_CONFIG_HOME/rust/cargo/env"

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  # Ensure existing Homebrew v1 completions continue to work
  export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Set custom MANPAGER
# ==================

# fixes formatting issues
export MANROFFOPT="-c"

# bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

# "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

if [[ "$(uname)" != "Darwin" ]]; then 
    export PATH=$PATH:/home///multitool/bin

    export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# RVM
# ===============

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


if [ "$(uname)" == "Darwin" ]; then
  source ~/.bashrc;
fi

