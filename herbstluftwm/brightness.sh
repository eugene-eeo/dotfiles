#!/bin/sh
bin='xfpm-power-backlight-helper'
mul='0.25'
cur=$(pkexec $bin --get-brightness)

case "$1" in
    +) pkexec $bin --set-brightness "$(echo "($cur*(1+$mul))/1" | bc)" ;;
    -) pkexec $bin --set-brightness "$(echo "($cur*(1-$mul))/1" | bc)" ;;
esac
