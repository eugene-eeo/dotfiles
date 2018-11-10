#!/bin/sh
volume=`amixer get Master | tail -n 1 | grep -o '[0-9]\+%' | grep -o '[0-9]\+'`
volume=".${volume}"

if [ "$1" = "+" ] && [ $(echo "$volume < 1" | bc) -eq 1 ]
then
    pactl set-sink-volume 0 +5%
elif [ "$1" = "-" ] && [ $(echo "$volume > 0" | bc) -eq 1 ]
then
    pactl set-sink-volume 0 -5%
fi
