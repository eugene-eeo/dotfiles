#!/bin/sh

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    test "`cat $BATS`" = "Charging" && echo -n '+'
    cat $BATC
}

volume() {
    amixer get Master | tail -n 1 | grep -o '[0-9]\+%'
}

network() {
    ssid=$(iwconfig wlp2s0 |grep ESSID | grep -o '".*"' | sed 's/"//g')
    echo -n $ssid
}

echo "battery\t$(battery)"
echo "volume\t$(volume)"
echo "network\t$(network)"
