picom &
if [ "$DESKTOP_SESSION" = 'bspwm' ]; then
	killall sxhkd
	pgrep -x sxhkd >/dev/null || sxhkd &
	killall polybar
	$HOME/.config/polybar/launch.sh >/dev/null 2>&1 &
fi
feh --bg-fill $HOME/Pictures/wp4.png &
pkill nextcloud
flatpak run com.nextcloud.desktopclient.nextcloud >/dev/null 2>&1 &
xsetroot -cursor_name left_ptr # remove x-shaped cursor when no windows open

# touchegg &
kitty
copyq &

./setup/keyboard/init.sh
./setup/screenlayout/monitor-on-top.sh
