#!/bin/sh
pactl set-sink-mute @DEFAULT_SINK@ 0
case "$1" in
    +) pactl set-sink-volume @DEFAULT_SINK@ '+2%' ;;
    -) pactl set-sink-volume @DEFAULT_SINK@ '-2%' ;;
esac
