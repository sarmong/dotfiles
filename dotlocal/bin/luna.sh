#!/usr/bin/env bash

# https://svs.gsfc.nasa.gov/5187
# https://svs.gsfc.nasa.gov/Gallery/moonphase.html
# https://github.com/desertplant/moon-phase-background

resolution="1920x1080"
year=$(date -u +%Y)
id="a005400/a005415"

cd /tmp || exit 1

# get current hour of the year
hour=$((10#$(date --utc +"%j") * 24 - 23 + 10#$(date --utc +"%H")))
echo "Hour of Year: $hour"

image="moon.$(printf "%04d" $hour).tif"
echo "Downloading $image..."
curl --location --remote-name --silent "https://svs.gsfc.nasa.gov/vis/a000000/$id/frames/${resolution}_16x9_30p/plain/$image" &

data=$(curl -L --silent "https://svs.gsfc.nasa.gov/vis/a000000/$id/mooninfo_$year.json" | jq ".[$hour]")

wait

phase=$(echo "$data" | jq .phase)
echo "Phase: $phase"

age=$(echo "$data" | jq .age)
echo "Days: $age"

text="Phase: $phase% Days: $age     "

composite -gravity center "$image" "$XDG_DOTFILES_DIR"/assets/stars.tif wp.png
convert -fill '#b1ada7' -pointsize 50 -gravity east -draw "text 100,1200 '$text'" wp.png wp.png

set-wp wp.png

rm "$image"
