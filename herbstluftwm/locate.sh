#!/bin/bash
xdg-open "$(find ~ -name '.*' -prune -o -print | rofi -threads 0 -width 50 -dmenu -i -p "locate: ")"
