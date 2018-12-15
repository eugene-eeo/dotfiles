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
font="Source Code Pro:medium:pixelsize=15"
bgcolor='#000000'
selbg=$(hc get window_border_active_color)
selfg='#000000'

####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

hc pad $monitor $panel_height

{
    while true ; do
        ~/.config/herbstluftwm/barmk.sh
        sleep 1 || break
    done &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    date=""
    windowtitle=""
    while true ; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        separator="^bg()^fg($selbg)|"
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
            if [ ! -z "$dzen2_svn" ] ; then
                # clickable tags if using SVN dzen
                echo -n "^ca(1,\"herbstclient\" "
                echo -n "focus_monitor \"$monitor\" && "
                echo -n "\"herbstclient\" "
                echo -n "use \"${i:1}\") ${i:1} ^ca()"
            else
                # non-clickable tags if using older dzen
                echo -n " ${i:1} "
            fi
        done
        echo -n "$separator"
        echo -n "^bg()^fg() ${windowtitle//^/^^}"
        # small adjustments
        right="$separator^fg() $date $separator^bg()^fg() $network $separator^bg()^fg() ^fg(#909090)V:^fg()$volume $separator^bg()^fg() ^fg(#909090)B:^fg()$battery%"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space..
        width=$(xftwidth "$font" "$right_text_only  ")
        echo -n "^p(_RIGHT)^p(-$width)$right"
        echo

        ### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "Special" events (quit_panel/reload) are also handled here.

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
            network)
                network="${cmd[@]:1}"
                ;;
            volume)
                volume="${cmd[@]:1}"
                ;;
            battery)
                battery="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
        esac
    done
} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -h $panel_height \
    -ta l -bg "$bgcolor" -fg '#efefef' \
    -fn "$font"
