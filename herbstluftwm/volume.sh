#!/bin/sh
sink='@DEFAULT_SINK@'
pactl set-sink-mute "$sink" 0
case "$1" in
    +) pactl set-sink-volume "$sink" '+2%' ;;
    -) pactl set-sink-volume "$sink" '-2%' ;;
esac
