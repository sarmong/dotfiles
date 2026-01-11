#!/bin/sh

timew | awk '
/^Tracking / {
  name = substr($0, index($0, "Tracking ") + 9)
}
/^  Total/ {
  print name " - " $2
}
'
