#!/usr/bin/env bash

path=$(mpvc --format '%path%')

## if streaming directly from yt-dlp
if [[ $path = https://* ]]; then
  url="$path"
else
  path=$(mpvc --format '%path%')
  tags=$(ffprobe -v quiet -print_format json -show_format "$path" | jq -r '.format.tags')
  url=$(echo "$tags" | jq -r '.PURL // .comment') # fallback
fi

xdg-open "$url"
