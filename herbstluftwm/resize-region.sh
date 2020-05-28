#!/bin/bash

winid=$(herbstclient attr clients.focus.winid)
[ "$winid" = '' ] && exit

read -r c x y w h < <(slop --tolerance=0 --color=0.66,0.23,0.23 --bordersize=3 -f "%c %x %y %w %h" -o)

# exit if cancelled
[ -z "$c" ] && exit

xdotool windowsize "$winid" "$w" "$h" \
        windowmove "$winid" "$x" "$y"
