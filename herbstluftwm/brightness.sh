#!/bin/dash
bin='pkexec xfpm-power-backlight-helper'
mul='0.25'
cur=$($bin --get-brightness)

case "$1" in
    +)
        $bin --set-brightness "$(echo "($cur*(1+$mul))/1 + 5" | bc)"
        [ "$($bin --get-brightness)" = "$cur" ] && {
            $bin --set-brightness "$($bin --get-max-brightness)"
        }
        ;;
    -)  $bin --set-brightness "$(echo "($cur*(1-$mul))/1 - 5" | bc)" ;;
esac
