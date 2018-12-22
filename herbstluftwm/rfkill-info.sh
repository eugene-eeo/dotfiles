#!/bin/bash

if [ ! "$1" ]; then
    st -g 30x3-0+20 -t rfkill-info \
       -f "Source Code Pro:medium:pixelsize=15:antialias=true:autohint=true" \
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


FGR=$(tput setaf 8)
BGR=$(tput setab 8)
MGN=$(tput setab 5)
BLU=$(tput setab 4)
RST=$(tput sgr 0)


rfkill_display() {
    IFS=$'\n'
    for line in $(rfkill_status); do
        name=$(echo "$line" | cut -d $'\t' -f1)
        stat=$(echo "$line" | cut -d $'\t' -f2)
        case "$name" in
            bluetooth) echo -e " ${BLU} B ${RST} $stat";;
            wlan)      echo -e " ${MGN} W ${RST} $stat" ;;
            *)         echo -e "${BGR} $name ${RST} $stat" ;;
        esac
    done
}

tput civis # hide cursor
rfkill_display
sleep 4
