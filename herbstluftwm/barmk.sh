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
    #nmcli --fields in-use,bars device wifi list | grep '^*' | cut -d ' ' -f8-9 | cut -d ' ' -f1
    iwgetid -r
}

date +'date	%H:%M %d/%m/%Y'
echo "battery\t$(battery)"
echo "volume\t$(volume)"
echo "network\t$(network)"
