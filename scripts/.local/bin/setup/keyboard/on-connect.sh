#!/usr/bin/env sh

event=$1
id=$2
type=$3

if [ "$event" = "XIDeviceEnabled" ] && [ "$type" = "XISlaveKeyboard" ]; then
  "$XDG_BIN_DIR/setup/keyboard/init.sh"
fi
