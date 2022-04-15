#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  source "$HOME/.bashrc"
fi

if [ -n "$BASH_VERSION" ] && [ -n "$PS1" ] && [ -z $BASHRC_LOADED ]; then
  source "$HOME/.bashrc"
fi
