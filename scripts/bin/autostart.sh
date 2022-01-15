# xrandr --output DP-1 --off --output HDMI-1 --mode 1920x1080 --pos 1366x0 --rotate normal --output eDP-1 --primary --mode 1366x768 --pos 0x304 --rotate normal --output HDMI-2 --off
# xrandr --output DP-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1366x768 --pos 1920x312 --rotate normal --output HDMI-2 --off
xrandr --output eDP-1 --primary --mode 1366x768 --pos 1998x312 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-2 --off
picom & 
if [ "$DESKTOP_SESSION" = 'bspwm' ]; then
killall sxhkd
    pgrep -x sxhkd > /dev/null || sxhkd &
    killall polybar
    $HOME/.config/polybar/launch.sh > /dev/null 2>&1 & 
fi
feh --bg-fill $HOME/Pictures/wp4.png &
pkill nextcloud
flatpak run com.nextcloud.desktopclient.nextcloud > /dev/null 2>&1 & 
xsetroot -cursor_name left_ptr # remove x-shaped cursor when no windows open

./setup/keyboard/init.sh
# touchegg &
kitty
copyq &
