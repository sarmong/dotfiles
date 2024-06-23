#!/bin/bash

bspc subscribe monitor | while read -r line; do
  event=$(echo "$line" | awk '{print $1}')

  case $event in

    ## Move all windows to a new monitor
    monitor_add)
      new_mon=$(echo "$line" | awk '{print $3}')
      all_mons=$(bspc query -M --names)
      another_mon=$(grep -Fxvf <(echo "$new_mon") <(echo "$all_mons") | sed -n 1p)

      if [ -n "$another_mon" ]; then
        bspc monitor "$new_mon" -d 1 2 3 4 7 8 9 0
        ~/.config/bspwm/bin/move_windows.sh "$another_mon" "$new_mon"

        ~/.config/polybar/launch.sh >/dev/null 2>&1 &
      fi

      feh --no-fehbg --bg-fill "$XDG_PICTURES_DIR"/wallpaper.png
      killall -SIGUSR1 conky &
      ;;

    ## Handle monitor disconnect / disabling
    monitor_geometry)
      active_mons="$(xrandr --listactivemonitors | awk '{print $4}' | tail -n +2)"
      bsp_mons=$(bspc query -M --names)
      removed_mon=$(grep -Fxvf <(echo "$active_mons") <(echo "$bsp_mons") | sed -n 1p)
      another_mon=$(echo "$active_mons" | sed -n 1p)

      if [ -n "$removed_mon" ] && [ -n "$another_mon" ]; then
        ~/.config/bspwm/bin/move_windows.sh "$removed_mon" "$another_mon"
        bspc monitor "$removed_mon" --remove

        ~/.config/polybar/launch.sh >/dev/null 2>&1 &
        killall -SIGUSR1 conky &
      fi

      feh --no-fehbg --bg-fill "$XDG_PICTURES_DIR"/wallpaper.png
      ;;

  esac

done &
