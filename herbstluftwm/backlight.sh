#!/bin/sh

# backlight_get
#       Print current keyboard brightness from UPower to stdout.
backlight_get()
{
    dbus-send --type=method_call --print-reply=literal --system         \
        --dest='org.freedesktop.UPower'                                 \
        '/org/freedesktop/UPower/KbdBacklight'                          \
        'org.freedesktop.UPower.KbdBacklight.GetBrightness'             \
        | awk '{print $2}'
}

# backlight_get_max
#       Print the maximum keyboard brightness from UPower to stdout.
backlight_get_max()
{
    dbus-send --type=method_call --print-reply=literal --system       \
        --dest='org.freedesktop.UPower'                               \
        '/org/freedesktop/UPower/KbdBacklight'                        \
        'org.freedesktop.UPower.KbdBacklight.GetMaxBrightness'        \
        | awk '{print $2}'
}

# backlight_set NUMBER
#       Set the current backlight brighness to NUMBER, through UPower
backlight_set()
{
    dbus-send --type=method_call --print-reply=literal --system       \
        --dest='org.freedesktop.UPower'                               \
        '/org/freedesktop/UPower/KbdBacklight'                        \
        'org.freedesktop.UPower.KbdBacklight.SetBrightness'           \
        "int32:$1}"
}

# Simulate wraparound of backlight
backlight_change()
{
    current=$( backlight_get )
    value=0
    if test "${current}" -lt `backlight_get_max` ; then
        value=$(( ${current} + 1 ))
    fi
    backlight_set "${value}"
}

backlight_change
