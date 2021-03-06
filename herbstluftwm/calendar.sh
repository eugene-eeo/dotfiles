#!/bin/bash
#
# pop-up calendar for dzen

# shellcheck disable=2207
width=240
monitor=( $(herbstclient list_monitors \
    | grep '\[FOCUS\]$' \
    | cut -d' ' -f2 \
    | tr x ' ' \
    | sed 's/\([-+]\)/ \1/g') )
x=$((monitor[2] + monitor[0]/2 - width/2))
padding=( $(herbstclient list_padding) )


today=$(date +'%-d')

{
    echo
    ncal -bh \
        | sed -r -e 's/^.+$/  \0  /' \
        | sed -r \
              -e 's/ Su Mo Tu We Th Fr Sa /^bg(#333333)\0^bg()/' \
              -e "s/(^|)( ?\\b${today}\\b ?)($|)/\\1^bg(#900603)^fg(#FFFFFF)\\2^fg()^bg()\\3/"
} \
    | dzen2 -p 60 -x $x -y "$(( padding[0] * 2 ))" -w $width -l 8 -sa c \
            -e 'onstart=uncollapse;button1=exit' \
            -fg '#EEEEEE' -bg '#111111' \
            -fn 'Hack:weight=bold:pixelsize=16'
