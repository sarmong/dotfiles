# ## Order is important
source "$ZDOTDIR"/zsh-functions

zsh_add_file "zsh-exports"
zsh_add_file "zsh-options"
zsh_add_file "zsh-completion"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt" true
zsh_add_file "zsh-vim-mode" true
zsh_add_file "zsh-local" true


HISTFILE="$XDG_CACHE_HOME"/zhistfile
HISTSIZE=10000000
SAVEHIST=10000000

stty stop undef # Disables C-s hang

zle_highlight=('paste:none') # Removes paste highlight


zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

bindkey '^r' history-incremental-search-backward

eval "$(zoxide init zsh)"
