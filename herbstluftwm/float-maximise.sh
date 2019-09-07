#!/bin/bash

hc() {
    herbstclient "$@"
}

main() {
    winid=$(hc attr clients.focus.winid)
    if [ "$winid" = '' ]; then
        return
    fi
    geometry=( $(hc monitor_rect -p "") )
    borderwidth=$(hc get_attr theme.floating.active.border_width)
    x=$(( borderwidth ))
    y=$(( borderwidth ))
    w=$(( geometry[2] - 2*borderwidth ))
    h=$(( geometry[3] - 2*borderwidth ))
    xdotool windowsize "$winid" "$w" "$h" \
            windowmove "$winid" "$x" "$y"
}

main
