HISTFILE="$XDG_CACHE_HOME"/zhistfile
HISTSIZE=10000
SAVEHIST=10000

stty stop undef # Disables C-s hang

zle_highlight=('paste:none') # Removes paste highlight

## Completion
zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

## Match case-insensitively
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source "$ZDOTDIR"/zsh-functions

zsh_add_file "zsh-options"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-exports"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-vim-mode"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

bindkey '^r' history-incremental-search-backward

eval "$(zoxide init zsh)"
