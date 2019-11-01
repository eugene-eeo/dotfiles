#!/bin/bash

hc() {
    herbstclient "$@";
}

monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "${geometry[0]}" ]; then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
#h=${geometry[3]}
panel_width=${geometry[2]}
panel_height=20
font="Consolas:weight=bold:pixelsize=15:autohint=true"
#font="Iosevka Term:weight=bold:pixelsize=16:autohint=true"
bgcolor='#000000'
selbg=$(hc get window_border_active_color)
selfg='#000000'
separator="^bg()^fg($selbg)|^fg()"

get_bat_charging() {
    BATS=/sys/class/power_supply/BAT0/status
    test "$(cat $BATS)" = "Discharging" && echo -n '-' || echo -n '+'
}

get_bat_level() {
    BATC=/sys/class/power_supply/BAT0/capacity
    cat $BATC
}

prev_bat='100'

proc_bat_info() {
    if [ "$1" -lt 20 ] && [ "$1" != "$2" ]; then
        notify-send "critical: $1%" -a "bat" -u critical
    fi
}

hc pad "$monitor" $panel_height
#hc pad "$monitor" 0 0 $panel_height 0

{
    echo nmcli
    echo pactl
    echo battery
    date +'date	%H:%M ^fg(#909090)%a %d %b'
    timeout 1 sh -c 'until nc -z localhost 9900; do sleep 0.01; done' && cat < /dev/tcp/localhost/9900
} 2> /dev/null | {
    # we get monitor-specific data here
    IFS=$'\t' read -ra tags <<< "$(hc tag_status "$monitor")"
    date=""
    network=""
    volume=""
    battery=""
    while true ; do
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg($selbg)^fg($selfg)"
                    ;;
                '+')
                    echo -n "^bg(#888888)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg()^fg(#ffffff)"
                    ;;
                '!')
                    echo -n "^bg(orange)^fg(#141414)"
                    ;;
                '-')
                    echo -n "^bg(#444444)^fg(#FFFFFF)"
                    ;;
                *)
                    echo -n "^bg()^fg(#666666)"
                    ;;
            esac
            echo -n "^ca(1,herbstclient focus_monitor \"$monitor\" && herbstclient use \"${i:1}\") ${i:1} ^ca()"
        done
        echo -n "$separator"
        # small adjustments
        right=" $separator^ca(1, \"$HOME/.config/herbstluftwm/calendar.sh\") $date ^ca()$separator $network $separator ^fg(#909090)V:^fg()$volume $separator ^fg(#909090)B:^fg()$battery%"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space..
        width=$(xftwidth "$font" "$right_text_only  ")
        echo -n "^p(_RIGHT)^p(-$width)$right"
        echo

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                IFS=$'\t' read -ra tags <<< "$(hc tag_status "$monitor")"
                ;;
            date)
                date="${cmd[*]:1}"
                ;;
            nmcli)
                network=$(iwgetid -r)
                ;;
            pactl)
                volume=$(get-volume)
                ;;
            battery)
                bat_level=$(get_bat_level)
                battery="$(get_bat_charging)${bat_level}"
                proc_bat_info "$bat_level" "$prev_bat"
                prev_bat=$bat_level
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | dzen2 -w "$panel_width" -x "$x" -y "$y" -h $panel_height \
    -ta l -bg "$bgcolor" -fg '#efefef' \
    -e 'button3=' \
    -fn "$font"
