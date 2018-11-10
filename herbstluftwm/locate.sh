#!/bin/bash
xdg-open "$(locate home media | rofi -threads 0 -width 100 -dmenu -i -p "locate:")"
