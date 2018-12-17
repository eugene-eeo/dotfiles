#!/bin/sh
sink='@DEFAULT_SINK@'
case "$1" in
    +) pactl set-sink-mute "$sink" 0; pactl set-sink-volume "$sink" '+2%' ;;
    -) pactl set-sink-mute "$sink" 0; pactl set-sink-volume "$sink" '-2%' ;;
    m) pactl set-sink-mute "$sink" toggle ;;
esac
