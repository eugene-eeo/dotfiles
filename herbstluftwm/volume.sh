#!/bin/sh
vol() {
    amixer get Master | tail -n 1 | grep -o '[0-9]\+%' | grep -o '[0-9]\+'
}

volume=`vol`

if [ "$1" = "+" ] && [ $(echo "$volume < 100" | bc) -eq 1 ]
then
    pactl set-sink-mute 0 0
    pactl set-sink-volume 0 '+2%'
elif [ "$1" = "-" ] && [ $(echo "$volume >= 0" | bc) -eq 1 ]
then
    pactl set-sink-volume 0 '-2%'
    if [ "`vol`" -eq 0 ]
    then
        pactl set-sink-mute 0 1
    else
        pactl set-sink-mute 0 0
    fi
fi
