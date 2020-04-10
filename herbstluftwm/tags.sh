#!/bin/bash
monitor=$(herbstclient list_monitors \
    | grep '\[FOCUS\]$' \
    | cut -d':' -f1)

bgcolor='#111'
selbg='#ccc'
selfg='#000'
font='Hack:weight=semibold:pixelsize=20'

# geometry calculation
width="322"
height="35"
IFS=" " read -r -a geometry <<< "$(herbstclient monitor_rect "$monitor")"
geom="${width}x${height}+$(( geometry[0] + (geometry[2] - width) / 2 ))+$(( geometry[1] + (geometry[3] - height) / 2 ))"

{
    echo -n '%{c}'
    IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status "$monitor")"
    for i in "${tags[@]}" ; do
        case ${i:0:1} in
            '#')
                echo -n "%{B$selbg}%{F$selfg}"
                ;;
            '+')
                echo -n "%{B#888888}%{F#141414}"
                ;;
            ':')
                echo -n "%{B-}%{F#ffffff}"
                ;;
            '!')
                echo -n "%{B#FFA500}%{F#141414}"
                ;;
            '-')
                echo -n "%{B#444444}%{F#FFFFFF}"
                ;;
            *)
                echo -n "%{B-}%{F#666666}"
                ;;
        esac
        echo -n " ${i:1} "
    done
    echo
    sleep 1
} | lemonbar \
    -B "$bgcolor" \
    -g "$geom" \
    -f "$font"
