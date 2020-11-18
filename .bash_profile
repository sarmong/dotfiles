export LC_ALL=en_US.UTF-8

 if [ -d "$HOME/Documents/android/adb-fastboot/platform-tools" ] ; then
  export PATH="$HOME/Documents/android/adb-fastboot/platform-tools:$PATH"
 fi

# export JAVA_HOME=$(/usr/libexec/java_home)
#export PATH=${PATH}:/usr/local/mysql/bin/

eval "$(lua $HOME/bin/z.lua --init bash enhanced once)"
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh 
# export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="$HOME/bin:$PATH";
export PATH="/usr/local/sbin:$PATH";
export EDITOR="vim";
export HISTCONTROL=ignoreboth:erasedups;

shopt -s cdspell  #accepts typing errors in cd dirs
shopt -s histappend  # infinite history
shopt -s autocd

set -o vi # sets vim mode

#Git auto-complete
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  # Ensure existing Homebrew v1 completions continue to work
  export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# # ~/.bashrc

# # If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# if [ -f /etc/bashrc ]; then
#         . /etc/bashrc
# fi

# if [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
# fi

# [ -z "$PS1" ] && return

# if [[ ${EUID} == 0 ]] ; then
# PS1='\[\e[01;31m\]\h\[\e[01;34m\] \W \$\[\e[00m\] '
# else
# PROMPT_COMMAND='__git_ps1 "\[\e[01;32m\]\u@\h\[\e[01;34m\] \W\[\e[00m\]" " \\\$ "'
# fi

# export EDITOR=vim

# export HISTSIZE=100000
# export HISTFILESIZE=1000000
# HISTCONTROL=ignoreboth:erasedups:ignorespace
# shopt -s histappend
# PROMPT_COMMAND="history -a; history -c; history -r;$PROMPT_COMMAND"

# # less colors
# export LESSOPEN='|pygmentize -f terminal256 -g -P style=monokai %s'
# export LESS='-R'

# # man pages in colores
# man() {
#     LESS_TERMCAP_md=$'\e[01;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[01;44;33m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[01;32m' \
#     command man "$@"
# }

# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8



# # import input rc for bash history
# export INPUTRC=~/.inputrc



# # git completion
# source ~/.git-completion.bash

# # git prompth
# source ~/.git-prompt.sh

##
# Your previous /Users/michael/.bash_profile file was backed up as /Users/michael/.bash_profile.macports-saved_2020-05-30_at_16:23:02
##

# MacPorts Installer addition on 2020-05-30_at_16:23:02: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


export PATH="$HOME/.cargo/bin:$PATH"
