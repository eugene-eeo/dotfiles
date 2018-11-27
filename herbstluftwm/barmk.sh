#!/bin/sh

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    test "`cat $BATS`" = "Discharging" && echo -n '-' || echo -n '+'
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

date +'date	%H:%M ^fg(#909090)%d %b'
echo "battery\t$(battery)"
echo "volume\t$(volume)"
echo "network\t$(network)"
