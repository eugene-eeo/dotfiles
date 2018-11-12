#!/bin/sh

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    test "`cat $BATS`" = "Charging" && echo -n '+' || echo -n '-'
    cat $BATC
}

volume() {
    info=`amixer get Master | tail -n 1`
    if [ $(echo $info | grep -o '\[\(on\|off\)\]') = '[off]' ]
    then
        echo -n 'MUTE'
    else
        echo $info | grep -o '[0-9]\+%'
    fi
}

network() {
    iwgetid -r
}

echo "battery\t$(battery)"
echo "volume\t$(volume)"
echo "network\t$(network)"
