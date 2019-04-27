#!/bin/bash

tag='#'
Mod='Super'

hc() {
    herbstclient "$@"
}

size=$(xwininfo -root |
       sed -n -e '/^  Width: / {
                      s/.*: //;
                      h
                  }
                  /^  Height: / {
                      s/.*: //g;
                      H;
                      x;
                      s/\n/x/p
                  }')

hc chain , add "$tag" , floating "$tag" on
hc or , add_monitor "${size}+0+0" "$tag" floatmon \
      , move_monitor floatmon "${size}+0+0"
hc pad floatmon 20
hc lock_tag floatmon

cmd=(
or  case: and
        # if not on the floating monitor, and a client is focused
        # then remember last monitor of client, and move client to
        # floating tag
        . compare monitors.focus.name != floatmon
        . get_attr clients.focus.winid
        . chain try new_attr string clients.focus.my_lastmon
                try true
        . substitute M monitors.focus.index
            set_attr clients.focus.my_lastmon M
        . shift_to_monitor floatmon
        . focus_monitor floatmon
        . true
    case: and
        # if on floating monitor, and client is focused then send
        # it back to where it came from
        . compare monitors.focus.name = floatmon
        . get_attr clients.focus.winid
        . substitute M clients.focus.my_lastmon chain
            , shift_to_monitor M
            , focus_monitor M
        . true
    case: and
        # just move to the first monitor
        . shift_to_monitor 0
        . focus_monitor 0
)

hc keybind $Mod-Shift-f "${cmd[@]}"
