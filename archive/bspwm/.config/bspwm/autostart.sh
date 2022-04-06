if [ "$DESKTOP_SESSION" = 'bspwm' ]; then
	killall sxhkd
	pgrep -x sxhkd >/dev/null || sxhkd &
	killall polybar
	$HOME/.config/polybar/launch.sh >/dev/null 2>&1 &
fi

xsetroot -cursor_name left_ptr # remove x-shaped cursor when no windows open
