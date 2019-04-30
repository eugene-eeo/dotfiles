#!/bin/bash

launch_one() {
    pgrep "$1" || pdetach $1
}

hydra-head | while read -r line; do
    case "$line" in
        # launch settings when headphones are connected
        pactl:card)
            launch_one 'settings sound'
            ;;
    esac
done
