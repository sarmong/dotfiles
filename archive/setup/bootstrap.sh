#!/usr/bin/env bash

# shellcheck disable=1007,2181
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir" || exit 1

log_dir="$script_dir/logs"
mkdir "$log_dir"

./packages/install.sh

if [ $? -gt 0 ]; then
  echo -e '\e[0m'
  exit 1
fi

./packages/build/init.sh | tee -a "$log_dir"/bootstrap.log

./link.sh | tee -a "$log_dir"/bootstrap.log

source ./dotconfig/bash/bash-exports

./configure.sh | tee -a "$log_dir"/bootstrap.log

echo "Logs are located in the $log_dir directory"
