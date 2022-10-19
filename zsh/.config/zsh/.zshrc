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
zsh_add_plugin "marzocchi/zsh-notify" "notify"

zstyle ':notify:*' error-title "Command failed (in #{time_elapsed} seconds)"
zstyle ':notify:*' success-title "Command finished (in #{time_elapsed} seconds)"


# Taken from https://www.reddit.com/r/zsh/comments/mczq2j/current_process_and_directory_as_window_title/
function xtitle () {
    builtin print -n -- "\e]0;$@\a"
}
function precmd () {
    xtitle "$(print -P '%~ | $TERM' )"
}
 function preexec () {
    xtitle "$(print -P '$1 | %~ | $TERM' )"
}

bindkey '^r' history-incremental-search-backward

eval "$(zoxide init zsh)"
