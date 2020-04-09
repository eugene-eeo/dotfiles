#!/bin/bash

hc() {
    herbstclient "$@"
}

get_window_geometry() {
    xdotool getwindowgeometry "$1" \
        | grep 'Geometry' \
        | cut -d ' ' -f4 \
        | tr x ' '
}

main() {
    winid=$(hc attr clients.focus.winid)
    if [ "$winid" = '' ]; then
        return
    fi
    monitor=( $(hc monitor_rect) )
    geometry=( $(get_window_geometry "$winid") )
    x=$(( monitor[0] + (monitor[2] - geometry[0]) / 2 ))
    # For some weird reason, monitor[1] + borderwidth causes the window to
    # move by +the padded amount, incorrectly.
    y=$(( monitor[1] + (monitor[3] - geometry[1]) / 2 ))
    xdotool windowmove "$winid" "$x" "$y"
}

main
