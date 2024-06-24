#!/bin/sh

DEVICE_NAME="iLoud Micro"

DEVICE_MAC=$(bluetoothctl devices | grep "$DEVICE_NAME" | awk '{print $2}')

if [ -n "$DEVICE_MAC" ]; then
  bluetoothctl connect "$DEVICE_MAC"
else
  echo "Device $DEVICE_NAME not found."
fi
