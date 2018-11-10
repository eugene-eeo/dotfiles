#!/bin/bash
xdg-open "$(locate ~ | rofi -threads 0 -width 100 -dmenu -i -p "locate: ")"
