#!/usr/bin/env bash

script_dir="$(dirname "${BASH_SOURCE[0]}")"
source "$script_dir/../dotconfig/zsh/xdg-cleanup"

ANSIBLE_PLAYBOOK=ansible/local.yml
ANSIBLE_CONFIG=ansible/ansible.cfg
ANSIBLE_LOG_PATH=log/ansible.log

DEVICE_ROLE_FILE=/var/lib/misc/ansible-role
ROLES=(main server media)

main() {
  saved_role=$(_get_saved_role)

  ANSIBLE_PLAYBOOK="./ansible/$saved_role.yml"

  if [ -z "$saved_role" ] || [ ! -f "$ANSIBLE_PLAYBOOK" ]; then
    role=$(_select "Select role: " "${ROLES[@]}")
    ANSIBLE_PLAYBOOK="ansible/$role.yml"

    _save_role "$role"
  fi

  mkdir -p "$(dirname $ANSIBLE_LOG_PATH)"

  echo -e "\nRunning $ANSIBLE_PLAYBOOK..."

  ANSIBLE_CONFIG=$ANSIBLE_CONFIG ANSIBLE_LOG_PATH=$ANSIBLE_LOG_PATH ansible-playbook "$ANSIBLE_PLAYBOOK" --ask-become-pass "$@"
}

_get_saved_role() {
  role="$(cat $DEVICE_ROLE_FILE 2>/dev/null)"
  echo "$role"
}

_save_role() {
  role="$1"
  echo "$role" | sudo tee "$DEVICE_ROLE_FILE"
}

_select() {
  PS3=$1
  shift
  items=("$@")

  select item in "${items[@]}"; do
    [[ $item ]] && break
  done

  echo "$item"
}

main "$@"
