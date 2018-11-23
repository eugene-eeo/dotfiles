#!/bin/bash
xdg-open "$(find ~ -name '.*' -prune -o -print | rofi -threads 0 -width 100 -dmenu -i -p "locate: ")"
