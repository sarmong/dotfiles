#!/bin/bash
WHEREAMI=$(cat /tmp/whereami)
kitty --directory="$WHEREAMI"
