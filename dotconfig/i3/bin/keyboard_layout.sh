#!/bin/sh

if [ "$BLOCK_BUTTON" = "1" ] || [ "$BLOCK_BUTTON" = "4" ]; then
  xkblayout-state set +1
fi

if [ "$BLOCK_BUTTON" = "3" ] || [ "$BLOCK_BUTTON" = "5" ]; then
  xkblayout-state set -1
fi

xkblayout-state print %s
