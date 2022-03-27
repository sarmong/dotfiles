# $- prints current set of options in the shell
# If not running interactive shell, don't do anything
[[ $- == *i* ]] || return

export BASHRC_LOADED=true

# Source other config files
[ -n "$PS1" ] && [ "$(uname)" != "Darwin" ] && source ~/.bash_profile

for file in "$XDG_CONFIG_HOME"/bash/{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Settings
# ===========

stty -ixon # Disables C-s hang

set -o vi # set vim mode

shopt -s cdspell    #accepts typing errors in cd dirs
shopt -s histappend # infinite history
shopt -s autocd     # cd just by typing dir name

# Git auto-complete
if [ -f "$XDG_CONFIG_HOME"/bash/git-completion.bash ]; then
	source "$XDG_CONFIG_HOME"/bash/git-completion.bash
	# complete for g alias
	__git_complete g __git_main
fi

if [ -f "$XDG_CONFIG_HOME"/bash/git-prompt.bash ]; then
	source "$XDG_CONFIG_HOME"/bash/git-prompt.sh
fi

if command -v mkcert &>/dev/null; then
	export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
fi

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

[[ -f "$XDG_CONFIG_HOME/lf/lfcd" ]] && source "$XDG_CONFIG_HOME/lf/lfcd"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
