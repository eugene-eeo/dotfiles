#!/bin/bash

hc() {
    herbstclient "$@";
}

monitor=${1:-0}
IFS=" " read -r -a geometry <<< "$(hc monitor_rect "$monitor")"
if [ -z "${geometry[0]}" ]; then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format X Y W H
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=20
# font="Hack:weight=bold:pixelsize=14:autohint=true:antialias=true"
font="Consolas:weight=bold:size=10:autohint=true:antialias=true"
bgcolor='#000000'
selbg=$(hc get window_border_active_color)
selfg="$bgcolor"
separator="%{B-}%{F$selbg}|%{F-}"

BATS=/sys/class/power_supply/BAT0/status
BATC=/sys/class/power_supply/BAT0/capacity

get_bat_charging() {
    [ "$(cat $BATS)" = "Discharging" ] && echo -n '-' || echo -n '+'
}

get_bat_level() {
    cat $BATC
}

prev_bat='100'

proc_bat_info() {
    if [ "$monitor" = 0 ] && [ "$1" -lt 20 ] && [ "$1" != "$2" ]; then
        notify-send "battery: $1%" -a "bat" -u critical
    fi
}

hc pad "$monitor" $panel_height

{
    date +'date	%H:%M %%{F#909090}%a %d %b'
    # echo ibus
    echo nmcli
    echo pactl
    echo battery
    echo
    hydra-head
} 2> /dev/null | {
    # we get monitor-specific data here
    IFS=$'\t' read -ra tags <<< "$(hc tag_status "$monitor")"
    date=""
    network=""
    volume=""
    battery=""
    # ibus=""
    while true ; do
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "%{B$selbg}%{F$selfg}"
                    ;;
                '+')
                    echo -n "%{B#888888}%{F#141414}"
                    ;;
                ':')
                    echo -n "%{B-}%{F#ffffff}"
                    ;;
                '!')
                    echo -n "%{B#FFA500}%{F#141414}"
                    ;;
                '-')
                    echo -n "%{B#444444}%{F#FFFFFF}"
                    ;;
                *)
                    echo -n "%{B-}%{F#666666}"
                    ;;
            esac
            echo -n "%{A:herbstclient focus_monitor \"$monitor\" && herbstclient use \"${i:1}\":} ${i:1} %{A}"
        done
        echo -n "$separator "
        # echo -n "$title"
        # small adjustments
        right="$separator%{A:\"$HOME/.config/herbstluftwm/calendar.sh\":} $date %{A}$separator $network $separator %{F#909090}V:%{F-}$volume $separator %{F#909090}B:%{F-}${battery}%"
        echo -n "%{r}$right"
        echo

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                IFS=$'\t' read -ra tags <<< "$(hc tag_status "$monitor")"
                ;;
            # window_title_changed|focus_changed)
            #     title="${cmd[2]}"
            #     ;;
            # ibus)
            #     case "$(ibus engine)" in
            #         'pinyin')  ibus="zh" ;;
            #         *)         ibus="en" ;;
            #     esac
            #     ;;
            date)
                date="${cmd[*]:1}"
                ;;
            nmcli)
                network="$(iwgetid --raw)"
                ;;
            pactl)
                volume="$(get-volume)"
                ;;
            battery)
                bat_level=$(get_bat_level)
                battery="$(get_bat_charging)${bat_level}"
                proc_bat_info "$bat_level" "$prev_bat"
                prev_bat=$bat_level
                ;;
            quit|reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | lemonbar \
    -g "${panel_width}x${panel_height}+${x}+${y}" \
    -f "${font}" \
    -B "${bgcolor}" \
    -F '#ffffff' \
    -u 0 | bash
