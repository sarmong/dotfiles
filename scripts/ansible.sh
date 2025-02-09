#!/usr/bin/env bash

set -euo pipefail

script_dir="$(dirname "${BASH_SOURCE[0]}")"
source "$script_dir/../dotconfig/zsh/xdg-cleanup"

ANSIBLE_PLAYBOOK=ansible/main.yml
ANSIBLE_CONFIG=ansible/ansible.cfg
ANSIBLE_INVENTORY=ansible/inventory.ini

ANSIBLE_LOG_PATH="log/$(date +"%y-%m")/$(date +"%d")/$(date +"%H-%M-%S").log"

VAULT_ENC_KEY_FILE="$XDG_DATA_HOME/ansible-key"
VAULT_KEY_FILE="/tmp/ansible-key"

DEVICE_ROLE_FILE=/var/lib/misc/ansible-role

main() {
  case "$1" in
    reencrypt)
      shift
      reencrypt_file "$@"
      ;;
    gen_vault_pass)
      shift
      gen_vault_pass "$@"
      ;;
    *)
      run_playbook "$@"
      ;;
  esac
}

run_playbook() {
  ## Prompt for password beforehand. Ansible become should work
  ## doesn't make sense for remote, think about it
  # sudo echo ""

  gen_vault_pass

  mkdir -p "$(dirname "$ANSIBLE_LOG_PATH")"

  echo -e "\nRunning $ANSIBLE_PLAYBOOK..."

  ANSIBLE_CONFIG=$ANSIBLE_CONFIG \
    ANSIBLE_LOG_PATH=$ANSIBLE_LOG_PATH \
    ansible-playbook "$ANSIBLE_PLAYBOOK" \
    --vault-pass-file="$VAULT_KEY_FILE" \
    --inventory "$ANSIBLE_INVENTORY" \
    --ask-become-pass \
    "$@"
}

gen_vault_pass() {
  if [ ! -f "$VAULT_ENC_KEY_FILE" ]; then
    echo -n "Enter main vault password: "
    read -rs password
    echo -e "\nEncrypt pass with a ${b}different${n} pass..."

    encrypted_pass=$(echo "$password" | ansible-vault encrypt -)

    echo "$encrypted_pass" >"$VAULT_ENC_KEY_FILE"
    echo "$password" >"$VAULT_KEY_FILE"

    chmod 600 "$VAULT_ENC_KEY_FILE"
    chmod 600 "$VAULT_KEY_FILE"
  fi

  if [ ! -f "$VAULT_KEY_FILE" ]; then
    echo "Decrypt vault pass..."
    ansible-vault decrypt "$VAULT_ENC_KEY_FILE" --output "$VAULT_KEY_FILE"
    chmod 600 "$VAULT_KEY_FILE"
  fi
}

reencrypt_file() {
  gen_vault_pass

  file="$1"

  enc_file=$(grep -oP '## Encrypted with ansible vault - \K[\w/-]+' "$file")

  ansible-vault encrypt --vault-pass-file $VAULT_KEY_FILE --output "$XDG_DOTFILES_DIR/$enc_file" "$file"
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

b=$(tput bold) # bold
n=$(tput sgr0) # normal

main "$@"
