#!/bin/sh
hc() {
    herbstclient "$@"
}

feh --bg-fill ~/Downloads/iu-yellow.png

# theme
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1
hc set frame_bg_normal_color '#565656'
hc set frame_bg_active_color '#aaaaaa'
hc set frame_border_width 0
hc set always_show_frame 1
hc set frame_bg_transparent 1
hc set frame_transparent_width 3
hc set frame_gap 2

hc attr theme.active.color '#cccccc'
hc attr theme.normal.color '#454545'
hc attr theme.urgent.color orange
hc attr theme.inner_width 0
hc attr theme.outer_width 0
hc attr theme.border_width 2
hc attr theme.floating.border_width 2
hc attr theme.floating.outer_width 0
hc attr theme.background_color '#141414'

hc set window_gap 0
hc set frame_padding 0
hc set smart_window_surroundings 0
hc set smart_frame_surroundings 1
hc set mouse_recenter_gap 50
