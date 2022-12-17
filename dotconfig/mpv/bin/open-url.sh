#!/usr/bin/env bash

path=$(mpvc --format '%path%')

## if streaming directly from yt-dlp
if [[ $path = https://* ]]; then
  url="$path"
else
  path=$(mpvc --format '%path%')
  url=$(ffprobe -v quiet -print_format json -show_format "$path" | jq -r '.format.tags.PURL')
fi

xdg-open "$url"
