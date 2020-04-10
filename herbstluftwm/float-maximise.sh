#!/bin/bash

hc() {
    herbstclient "$@"
}

winid=$(hc attr clients.focus.winid)
if [ "$winid" = '' ]; then
    return
fi
padding=( $(hc list_padding) )
geometry=( $(hc monitor_rect) )
borderwidth=$(hc get_attr theme.floating.active.border_width)
x=$(( padding[3] + geometry[0] + borderwidth ))
y=$(( padding[0] + geometry[1] + borderwidth ))
w=$(( geometry[2] - padding[1] - padding[3] - 2*borderwidth ))
h=$(( geometry[3] - padding[0] - padding[2] - 2*borderwidth ))
xdotool windowsize "$winid" "$w" "$h" \
        windowmove "$winid" "$x" "$y"
