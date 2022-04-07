#!/bin/sh -e

# for device in XHC EHC1 EHC2; do
#     grep $device /proc/acpi/wakeup | grep enabled > /dev/null && {
#         echo Disabling wakeup on $device 
#         sudo sh -c 'echo $device | tee /proc/acpi/wakeup'
#     }
# done

# exit 0

if grep XHC /proc/acpi/wakeup | grep enable > /dev/null; then
  sudo sh -c 'echo XHC > /proc/acpi/wakeup'
fi
