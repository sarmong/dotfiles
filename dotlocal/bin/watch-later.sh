#!/usr/bin/env bash

wl_file="$XDG_NC_DIR/mpv/watch-later.txt"

add() {
  path=${1:-$(mpvc --format '%path%')}
  name=$(yt-dlp --no-playlist --print title "$path")
  date=$(date '+%Y-%m-%d %H:%M:%S')

  echo -e "$name\n$path\n$date\n" >>"$wl_file"
}

load() {
  urls=$(grep "https://" "$wl_file")

  for url in $urls; do
    echo "loadfile $url append-play" | socat - /tmp/mpvsocket
  done
}

case "$1" in
  add) add ;;
  load) load ;;
  *) add "$(xclip -sel clip -o)" ;;
esac
