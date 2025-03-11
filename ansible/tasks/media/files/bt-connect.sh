#!/bin/sh

DEVICE_NAME="iLoud Micro"

bluetoothctl devices >/var/lib/kodi/bt-connect.log

DEVICE_MAC=$(bluetoothctl devices | grep "$DEVICE_NAME" | awk '{print $2}')

if [ -n "$DEVICE_MAC" ]; then
  echo "has mac" >>/var/lib/kodi/bt-connect.log
  bluetoothctl connect "$DEVICE_MAC"
  echo "connected" >>/var/lib/kodi/bt-connect.log
else
  echo "Device $DEVICE_NAME not found." >>/var/lib/kodi/bt-connect.log
fi
