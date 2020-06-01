#!/bin/bash
hc() { herbstclient "$@"; }

font="Hack:weight=bold:pixelsize=14:autohint=true:antialias=true"

hc --idle 'focus_changed|tag_changed' | \
    {
        curr_mon="0"
        curr_tag=""
        curr_focus=""
        while true; do
            IFS=$'\t' read -ra cmd || break
            case "${cmd[0]}" in
                focus_changed) curr_focus="${cmd[1]}" ;;
                tag_changed)
                    curr_tag="${cmd[1]}";
                    curr_mon=$(hc attr monitors.focus.index)
                    echo "$curr_mon" > /dev/stderr
                    ;;
            esac

            # center align everything
            echo -n "%{S$curr_mon}%{c}"

            IFS=', '
            for wid in $(xprop -root | grep '^_NET_CLIENT_LIST(WINDOW)' | cut -d ' ' -f5-); do
                if [ "$(hc attr "clients.${wid}.tag")" = "$curr_tag" ]; then
                    title=$(hc attr "clients.${wid}.title")
                    if [ "$wid" = "$curr_focus" ]; then
                        echo -n "%{+u} $title %{-u}"
                    else
                        echo -n " %{A:herbstclient jumpto \"$wid\" && herbstclient raise \"$wid\":}$title%{A} "
                    fi
                fi
            done
            echo
        done
    } | lemonbar -U '#fff' -g '1920x20' -f "$font" -u 2 | sh
