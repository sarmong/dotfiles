#!/bin/sh

notify-send "$(yt-dlp --print duration_string "$1")"
