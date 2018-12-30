#!/bin/sh

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    test "`cat $BATS`" = "Discharging" && echo -n '-' || echo -n '+'
    cat $BATC
}

date +'date	%H:%M ^fg(#909090)%d %b'
echo "battery	$(battery)"
