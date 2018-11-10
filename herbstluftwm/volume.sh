#!/bin/sh
vol() {
    volume=`amixer get Master | tail -n 1 | grep -o '[0-9]\+%' | grep -o '[0-9]\+'`
    echo -n ".${volume}"
}

volume=`vol`

if [ "$1" = "+" ] && [ $(echo "$volume < 1" | bc) -eq 1 ]
then
    pactl set-sink-mute 0 0
    pactl set-sink-volume 0 '+2%'
elif [ "$1" = "-" ] && [ $(echo "$volume >= 0" | bc) -eq 1 ]
then
    pactl set-sink-volume 0 '-2%'
    if [ $(echo "$(vol) == 0" | bc) -eq 1 ]
    then
        pactl set-sink-mute 0 1
    else
        pactl set-sink-mute 0 0
    fi
fi
