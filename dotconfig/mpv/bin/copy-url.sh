#!/usr/bin/env bash

path=$(mpvc --format '%path%')

## if streaming directly from yt-dlp
if [[ $path = https://* ]]; then
  notify-send "here"
  url="$path"
else
  path=$(mpvc --format '%path%')
  url=$(ffprobe -v quiet -print_format json -show_format "$path" | jq -r '.format.tags.PURL')
fi

echo "$url" | xclip -sel clip

notify-send 'URL copied to clipboard'
