#!/bin/sh

if [ "$BLOCK_BUTTON" = "1" ]; then
  xkblayout-state set +1
fi

if [ "$BLOCK_BUTTON" = "3" ]; then
  xkblayout-state set -1
fi

xkblayout-state print %s
