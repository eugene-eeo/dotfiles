#!/bin/sh
CURRNAME=$(xrandr | grep " connected" | cut -f1 -d " ")
CURRBRIGHT=$(xrandr --current --verbose | grep -m 1 'Brightness:' | cut -f2- -d:)
if [ "$1" = "+" ] && [ $(echo "$CURRBRIGHT < 1.25" | bc) -eq 1 ]
then
xrandr --output $CURRNAME --brightness $(echo "$CURRBRIGHT * 1.05" | bc)
elif [ "$1" = "-" ] && [ $(echo "$CURRBRIGHT > 0" | bc) -eq 1 ]
then
xrandr --output $CURRNAME --brightness $(echo "$CURRBRIGHT * 0.95" | bc)
fi