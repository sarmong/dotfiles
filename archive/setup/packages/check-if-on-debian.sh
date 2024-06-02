#!/usr/bin/env bash

packages=$(sed 's/#.*$//g' "./arch.txt" | sed '/^$/d')

IFS=$'\n'
for package in $packages; do
  package_name=$(echo "$package" | awk '{ print $1 }')
  if ! apt search "$package_name" >/dev/null 2>&1; then
    echo "$package_name"
  fi
done
