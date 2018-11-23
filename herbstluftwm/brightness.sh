#!/bin/sh
MIN='100'
MAX=$(pkexec xfpm-power-backlight-helper --get-max-brightness)
CUR=$(pkexec xfpm-power-backlight-helper --get-brightness)

if [ "$1" = "+" ] && [ $(echo "$CUR < $MAX" | bc) -eq 1 ]
then
    pkexec xfpm-power-backlight-helper --set-brightness $(echo "($CUR*1.25)/1" | bc)
elif [ "$1" = "-" ] && [ $(echo "$CUR > $MIN" | bc) -eq 1 ]
then
    pkexec xfpm-power-backlight-helper --set-brightness $(echo "($CUR*0.75)/1" | bc)
fi
