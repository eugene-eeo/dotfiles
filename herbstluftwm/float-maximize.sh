#!/bin/bash

# maximize a window in floating mode
w=$(herbstclient get_attr clients.focus.winid)
geom=( $(herbstclient monitor_rect -p +0) )
borderwidth=$(herbstclient get_attr theme.floating.active.border_width)
geom[0]=$(( ${geom[0]} + borderwidth ))
geom[1]=$(( ${geom[1]} + borderwidth ))
geom[2]=$(( ${geom[2]} - 2* borderwidth ))
geom[3]=$(( ${geom[3]} - 2* borderwidth ))

xdotool windowmove $w ${geom[0]} ${geom[1]} \
    windowsize $w ${geom[2]} ${geom[3]}
