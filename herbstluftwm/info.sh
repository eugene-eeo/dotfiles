#!/bin/bash
# shellcheck disable=2207
monitor=( $(herbstclient list_monitors \
    | grep '\[FOCUS\]$' \
    | cut -d' ' -f2 \
    | tr x ' ' \
    | sed 's/\([-+]\)/ \1/g') )

bgcolor='#111'
fgcolor='#FFF'
font='Hack:weight=bold:pixelsize=18'

# geometry calculation
width="500"
height="200"
x=$((monitor[2] + monitor[0]/2 - width/2))
y=$((monitor[3] + monitor[1]/2 - height/2))

get_bat_charging() {
    BATS=/sys/class/power_supply/BAT0/status
    test "$(cat $BATS)" = "Discharging" && echo -n '-' || echo -n '+'
}

get_bat_level() {
    BATC=/sys/class/power_supply/BAT0/capacity
    cat $BATC
}

# info
wifi=$(iwgetid --raw)
time=$(date +'%H:%M:%S %a %d %b')
volume=$(get-volume)
battery="$(get_bat_charging)$(get_bat_level)"
ibus=$(ibus engine)

{
    echo "^fg(#333)────────────────────────────────────────────────────────────────────────────────────────────────────"
    echo "^fg(#666)   ibus:^fg() $ibus"
    echo "^fg(#666)   time:^fg() $time"
    echo "^fg(#666)    net:^fg() $wifi"
    echo "^fg(#666)    vol:^fg() $volume"
    echo "^fg(#666)    bat:^fg() $battery%"
    echo "^fg(#333)────────────────────────────────────────────────────────────────────────────────────────────────────"
} | dzen2 \
    -p 30 -l 6 -x "$x" -y "$y" -w "$width" -h "20" \
    -e 'onstart=uncollapse;button1=exit' \
    -fg "$fgcolor" -bg "$bgcolor" \
    -fn "$font"
