#!/usr/bin/env bash

hc() {
    herbstclient "$@";
}

monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=20
#font="Source Code Pro:medium:pixelsize=15:autohint=true"
#font="IBM Plex Mono:medium:pixelsize=14:autohint=true"
font="Consolas:pixelsize=15:autohint=true"
#font="Source Code Pro:semibold:pixelsize=15:autohint=true"
bgcolor='#000000'
selbg=$(hc get window_border_active_color)
selfg='#000000'
separator="^bg()^fg($selbg)|^fg()"

get_bat_info() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    test "`cat $BATS`" = "Discharging" && echo -n '-' || echo -n '+'
    cat $BATC
}

hc pad $monitor $panel_height
pdetach hydra

{
    hydra-head &
    echo nmcli
    echo pactl
    echo battery
    date +'date	%H:%M ^fg(#909090)%d %b'
    hc --idle
    kill $(jobs -p)
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    date=""
    windowtitle=""
    while true ; do
        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

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
            echo -n "^ca(1,\"herbstclient\" "
            echo -n "focus_monitor \"$monitor\" && "
            echo -n "\"herbstclient\" "
            echo -n "use \"${i:1}\") ${i:1} ^ca()"
        done
        echo -n "$separator"
        echo -n "^bg()^fg() ${windowtitle//^/^^}"
        # small adjustments
        right=" $separator $date $separator^ca(1, \"$HOME/.config/herbstluftwm/rfkill-info.sh\") $network ^ca()$separator ^fg(#909090)V:^fg()$volume $separator ^fg(#909090)B:^fg()$battery%"
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
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                date="${cmd[@]:1}"
                ;;
            nmcli)
                network=$(iwgetid -r)
                ;;
            pactl)
                volume=$(get-volume)
                ;;
            battery)
                battery=$(get_bat_info)
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                killall hydra
                exit
                ;;
        esac
    done
} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -h $panel_height \
    -ta l -bg "$bgcolor" -fg '#efefef' \
    -fn "$font"
