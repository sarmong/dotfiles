#!/usr/bin/env bash

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir" || exit 1

./packages/install.sh

./packages/build/init.sh | tee -a ./bootstrap.log

./setup.sh | tee -a ./bootstrap.log

source ./dotconfig/bash/bash-exports

./configure.sh | tee -a ./bootstrap.log
