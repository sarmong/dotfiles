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

compton &

killall touchegg
touchegg &

killall copyq
copyq &

killall udiskie
udiskie &

killall pasystray
pasystray &

~/bin/setup/keyboard/init.sh
~/bin/setup/screenlayout/monitor-on-top.sh

bluetooth on

kitty
