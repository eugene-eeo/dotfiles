#!/bin/bash

if [ ! "$1" ]; then
    st -g 30x3-0+20 -t rfkill-info \
       -f "IBM Plex Mono:pixelsize=14:antialias=true:autohint=true" \
       -e "$0" 1
    exit
fi

rfkill_status() {
    rfkill | tail +2 | tr -s ' ' | cut -d ' ' -f3,5,6 | while read -r line; do
        name=$(echo "$line" | cut -d ' ' -f1)
        soft_status=$(echo "$line" | cut -d ' ' -f2)
        hard_status=$(echo "$line" | cut -d ' ' -f3)
        if [ "$soft_status" = 'blocked' ] || [ "$hard_status" = 'blocked' ]; then
            echo -e "$name\toff"
        else
            echo -e "$name\ton"
        fi
    done
}


RED=$(tput setaf 1)
GRN=$(tput setaf 2)
RST=$(tput sgr 0)


rfkill_display() {
    IFS=$'\n'
    for line in $(rfkill_status); do
        name=$(echo "$line" | cut -d $'\t' -f1)
        stat=$(echo "$line" | cut -d $'\t' -f2)
        color=$GRN
        if [ "$stat" = 'off' ]; then
            color=$RED
        fi
        echo " $name $color$stat$RST"
    done
}

tput civis # hide cursor
rfkill_display
sleep 4
