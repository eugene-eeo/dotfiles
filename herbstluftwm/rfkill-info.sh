#!/bin/bash
#
# pop-up rfkill-info for dzen
# shellcheck disable=2004

font='Operator Mono Medium:pixelsize=16'
monitor=( $(herbstclient list_monitors \
    | grep '\[FOCUS\]$' \
    | cut -d' ' -f2 \
    | tr x ' ' \
    | sed 's/\([-+]\)/ \1/g') )
padding=( $(herbstclient list_padding) )

output=$(rfkill)
lines=$(echo "$output" | wc -l)


width=$( xftwidth "$font" "$(echo "   $output   " | head -n 1)" )
x=$((${monitor[2]} + ${monitor[0]}/2 - width/2))

{
    echo
    echo "$output"
} \
    | dzen2 -p 60 -x $x -y "$(( ${padding[0]} * 2 ))" -w $width -l "$((lines + 2))" -sa c \
            -e 'onstart=uncollapse;button1=exit' \
            -fg '#EEEEEE' -bg '#111111' \
            -fn "$font"
