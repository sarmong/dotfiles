#!/bin/sh -e

devices='XHC EHC1 EHC2 LID LID0'

for device in $devices; do
  if grep "$device" /proc/acpi/wakeup | grep enable >/dev/null; then
    echo "Disabling wakeup on $device"
    sudo sh -c "echo $device > /proc/acpi/wakeup"
  fi
done
