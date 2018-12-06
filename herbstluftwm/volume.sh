#!/bin/sh
vol() {
    amixer get Master | tail -n 1 | grep -o '[0-9]\+%' | grep -o '[0-9]\+'
}

volume=`vol`

if [ "$1" = "+" ] && [ $(echo "$volume < 100" | bc) -eq 1 ]
then
    pactl set-sink-mute @DEFAULT_SINK@ 0
    pactl set-sink-volume @DEFAULT_SINK@ '+2%'
elif [ "$1" = "-" ] && [ $(echo "$volume >= 0" | bc) -eq 1 ]
then
    pactl set-sink-volume @DEFAULT_SINK@ '-2%'
fi
