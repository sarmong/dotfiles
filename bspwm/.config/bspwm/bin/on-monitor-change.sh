#!/bin/bash

bspc subscribe monitor | while read -r line; do
  # echo "$line"

  event=$(echo "$line" | awk '{print $1}')

  case $event in

    ## Move all windows to a new monitor
    monitor_add)
      new_mon=$(echo "$line" | awk '{print $3}')
      all_mons=$(bspc query -M --names)
      another_mon=$(grep -Fxvf <(echo "$new_mon") <(echo "$all_mons") | sed -n 1p)

      if [ -n "$another_mon" ]; then
        echo "new_mon" "$new_mon"
        echo "all_mons" "$all_mons"
        echo "another_monitor" "$another_mon"
        echo "--------------------"
        bspc monitor "$new_mon" -d I II III IV V VI VII VIII IX X
        ~/.config/polybar/launch.sh >/dev/null 2>&1 &
        ~/.config/bspwm/bin/move_windows.sh "$another_mon" "$new_mon"
      fi
      ;;

    ## Handle monitor disconnect / disabling
    monitor_geometry)
      active_mons="$(xrandr --listactivemonitors | awk '{print $4}' | tail -n +2)"
      bsp_mons=$(bspc query -M --names)
      removed_mon=$(grep -Fxvf <(echo "$active_mons") <(echo "$bsp_mons") | sed -n 1p)
      another_mon=$(echo "$active_mons" | sed -n 1p)
      echo "active_mons" "$active_mons"
      echo "bsp_mons" "$bsp_mons"
      echo "removed_mon" "$removed_mon"
      echo "--------------------"

      if [ -n "$removed_mon" ] && [ -n "$another_mon" ]; then
        echo "active_mons" "$active_mons"
        echo "bsp_mons" "$bsp_mons"
        echo "removed_mon" "$removed_mon"
        echo "--------------------"
        ~/.config/bspwm/bin/move_windows.sh "$removed_mon" "$another_mon"
        bspc monitor "$removed_mon" --remove
        ~/.config/polybar/launch.sh >/dev/null 2>&1 &
      fi
      ;;

  esac

done &
