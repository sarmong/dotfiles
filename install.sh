#!/bin/sh

#####################
### CONFIGURATION ###
#####################
DOTFILES_DIR="$HOME/docs/dotfiles"
TEMP_LOG_PATH="/tmp/install.log"
LOG_PATH="$DOTFILES_DIR/log/install.log"

############
### MAIN ###
############
main() {
  current_user="$USER"
  sudo_group="sudo"

  if ! id -nG "$current_user" | grep -qw "$sudo_group"; then
    _task "Install sudo and add user to sudo group"
    su - root -c "apt-get install -y sudo && adduser $current_user sudo" >/dev/null
    printf "\n%b You need to relogin and restart script to use sudo. %b\n" "$BYELLOW" "$NC"
    exit 0
  fi

  sudo echo "" # Prompt for password before running _task

  _task "Apt update"
  _cmd "sudo apt-get update"

  _task "Apt upgrade"
  _cmd "sudo apt-get -y upgrade"

  _task "Install git, ansible, python3-watchdog" ## TODO: watchdog used by beautiful-output, check if needed
  _cmd "sudo apt-get install -y git ansible python3-watchdog"

  if [ ! -d "$DOTFILES_DIR" ]; then
    _task "Clone dotfiles"
    _cmd "git clone --quiet https://github.com/sarmong/dotfiles.git $DOTFILES_DIR"
  fi

  cd "$DOTFILES_DIR" || exit 1

  _task "Change repo url to SSH"
  _cmd "git remote set-url origin git@github.com:sarmong/dotfiles.git"

  _task "Initialize dotfiles repo"
  _cmd "./Taskfile init"

  _task "Saving logs into $LOG_PATH"
  _cmd "mkdir -p $(dirname "$LOG_PATH") && cat $TEMP_LOG_PATH >>$LOG_PATH"

  _task_done

  printf "\n%b Running ansible playbook... %b\n" "$BYELLOW" "$NC"
  ./Taskfile ansible

  # shellcheck disable=2181
  if [ "$?" -gt 0 ]; then
    printf "\n%bAnsible failed, fix the issue and run %b'./Taskfile ansible'\n%b" "$BRED" "$CYAN" "$NC"
  else
    printf "\n%b✓ Installation finished!%b\n" "$GREEN" "$NC"
    printf "%b▶ Please reboot your computer to complete the setup.%b\n" "$CYAN" "$NC"
  fi

}

#################
### UTILITIES ###
#################
NC='\e[0m'
OVERWRITE='\e[1A\e[K'
CYAN='\e[0;36m'
BRED='\e[1;31m'
GREEN='\e[0;32m'
BGREEN='\e[1;32m'
BYELLOW='\e[1;33m'
_task_done() {
  printf "%b%b [✓] %s\n%b" "$OVERWRITE" "$BGREEN" "$TASK" "$NC"
  TASK=""
}
_task() {

  if [ "$TASK" != "" ]; then
    _task_done
  fi

  TASK=$1
  printf "%b [⧖] %s \n%b" "$BYELLOW" "$TASK" "$NC"
}
_cmd() {
  if ! [ -f "$TEMP_LOG_PATH" ]; then
    mkdir -p "$(dirname "$TEMP_LOG_PATH")"
    touch "$TEMP_LOG_PATH"
  fi
  # hide stdout, on error we print and exit
  if eval "$1" 1>/dev/null 2>"$TEMP_LOG_PATH"; then
    return 0 # success
  fi
  # read error from log and add spacing
  printf "%b%b [X]  %s\n%b" "$OVERWRITE" "$BRED" "$TASK" "$BRED"

  while read -r line; do
    printf "      %s\n" "$line"
  done <"$TEMP_LOG_PATH"
  printf "\n"

  exit 1
}

main
