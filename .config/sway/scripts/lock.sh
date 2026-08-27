#!/bin/sh

# 1. Identify focused monitor
MONITOR=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

# 2. Capture screenshot, blur it and lock
grim -o "$MONITOR" /tmp/screen.png
convert /tmp/screen.png -blur 0x8 /tmp/screen.png

# 3. Lock the screen
swaylock -i /tmp/screen.png --clock --indicator
