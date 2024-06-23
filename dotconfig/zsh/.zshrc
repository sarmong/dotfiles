# ## Order is important
source "$ZDOTDIR"/zsh-functions

fpath+="$ZDOTDIR/zfunc"

zsh_add_file "zsh-exports"
zsh_add_file "zsh-coding"
zsh_add_file "zsh-options"
zsh_add_file "zsh-completion"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-local"


HISTFILE="$XDG_CACHE_HOME"/zhistfile
HISTSIZE=10000000
SAVEHIST=10000000

stty stop undef # Disables C-s hang

zle_highlight=('paste:none') # Removes paste highlight

## Automatically escapes symbols in URL
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

compdef _setsid dis # Use setsid completion for dis

zsh_add_file "/usr/share/zsh/plugins/forgit/forgit.plugin.zsh"
zsh_add_file "/usr/share/zsh/plugins/forgit/completions/git-forgit.zsh"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "joshskidmore/zsh-fzf-history-search"
# @TODO take it out
zsh_add_plugin "grigorii-zander/zsh-npm-scripts-autocomplete"

if [ -n "$DISPLAY" ]; then
  zsh_add_plugin "marzocchi/zsh-notify" "notify"
  zstyle ':notify:*' error-title "Command failed (in #{time_elapsed} seconds)"
  zstyle ':notify:*' success-title "Command finished (in #{time_elapsed} seconds)"
  zstyle ':notify:*' expire-time 10000
fi


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

# bindkey '^r' history-incremental-search-backward

exists zoxide && eval "$(zoxide init zsh)"
