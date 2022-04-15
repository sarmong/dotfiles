# $- prints current set of options in the shell
# If not running interactive shell, don't do anything
[[ $- == *i* ]] || return

export BASHRC_LOADED=true

# Source other config files
[ -n "$PS1" ] && [ "$(uname)" != "Darwin" ] && source ~/.bash_profile

for file in "$XDG_CONFIG_HOME"/bash/{bash_prompt,bash-aliases,bash-exports,.env,git-completion.bash,git-prompt.sh}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Settings
# ===========

stty -ixon # Disables C-s hang

set -o vi # set vim mode

shopt -s cdspell    #accepts typing errors in cd dirs
shopt -s histappend # infinite history
shopt -s autocd     # cd just by typing dir name

# Bash completion
if which brew &>/dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  # Ensure existing Homebrew v1 completions continue to work
  export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# bash completion for for g alias
__git_complete g __git_main

# FZF settings
# =============
if [ -d /usr/share/fzf ]; then
  # fzf hotkeys https://wiki.archlinux.org/title/Fzf
  source /usr/share/fzf/completion.bash
  source /usr/share/fzf/key-bindings.bash
fi

if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --require-git -g='!.git/**/*'"
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

eval "$(zoxide init bash)"
