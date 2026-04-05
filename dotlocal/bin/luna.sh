#!/usr/bin/env bash

# https://svs.gsfc.nasa.gov/5187
# https://svs.gsfc.nasa.gov/Gallery/moonphase.html
# https://github.com/desertplant/moon-phase-background

resolution="1920x1080"
year=$(date -u +%Y)
id="a005500/a005587"
hour_of_year=$((10#$(date --utc +"%j") * 24 - 23 + 10#$(date --utc +"%H")))

tmp_dir=/tmp/luna-sh

if [ ! -d "$tmp_dir" ]; then
  mkdir "$tmp_dir"
fi

get_image() {
  image_file="moon.$(printf "%04d" $hour_of_year).tif"
  image_path="$tmp_dir/$image_file"

  if [ ! -f "$image_path" ]; then
    curl --location --silent "https://svs.gsfc.nasa.gov/vis/a000000/$id/frames/${resolution}_16x9_30p/plain/$image_file" --output "$image_path" 2>/dev/null
  fi
  echo "$image_path"
}
get_json() {
  json_file=mooninfo_$year.json
  json_path="$tmp_dir/$json_file"

  if [ ! -f "$json_path" ]; then
    curl -L --silent "https://svs.gsfc.nasa.gov/vis/a000000/$id/$json_file" --output "$json_path" 2>/dev/null
  fi
  echo "$json_path"
}

get_text() {
  json_path=$(get_json)

  cur_hour_data=$(jq ".[$hour_of_year]" <"$json_path")

  phase=$(echo "$cur_hour_data" | jq .phase)
  age=$(echo "$cur_hour_data" | jq .age)

  echo "Phase: $phase%  Days: $age     "
}

set_as_wp() {
  image_path="$(get_image)"
  text=$(get_text)

  composite -gravity center "$image_path" "$XDG_DOTFILES_DIR"/assets/stars.tif "$tmp_dir/wp.png"
  convert -fill '#b1ada7' -pointsize 50 -gravity east -draw "text 100,1200 '$text'" "$tmp_dir/wp.png" "$tmp_dir/wp.png"

  set-wp "$tmp_dir/wp.png"
  rm "$image_path"
}

bar() {
  json_path=$(get_json)
  cur=$(jq ".[$hour_of_year]" <"$json_path")
  next=$(jq ".[$((hour_of_year + 1))]" <"$json_path")

  phase=$(echo "$cur" | jq -r '.phase')
  distance=$(echo "$cur" | jq -r '.distance')
  next_phase=$(echo "$next" | jq -r '.phase')

  is_increasing=$(echo "$next_phase > $phase" | bc -l)
  is_full_now=$(echo "$phase > 99" | bc -l)
  is_full_soon=$(echo "$phase > 95 && $phase < 99 && $is_increasing" | bc -l)
  is_supermoon=$(echo "$distance > 405000" | bc -l)
  is_micromoon=$(echo "$distance < 360000" | bc -l)

  if ((is_supermoon)) && ((is_full_now)); then
    echo "🌝"
  elif ((is_micromoon)) && ((is_full_now)); then
    echo "🌚"
  elif ((is_full_now)); then
    echo "🌕"
  elif ((is_full_soon)); then
    echo "🌔⏳"
  elif ((is_supermoon)); then
    echo "🌖"
  elif ((is_micromoon)); then
    echo "🌒"
  else
    echo ""
  fi
}

case "$1" in
  set_wp) set_as_wp ;;
  bar) bar ;;
  *) echo "Specify set_wp or bar option" ;;
esac
