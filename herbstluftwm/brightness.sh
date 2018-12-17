#!/bin/sh
bin='pkexec xfpm-power-backlight-helper'
mul='0.25'
cur=`$bin --get-brightness`

case "$1" in
    +) $bin --set-brightness "`echo "($cur*(1+$mul))/1" | bc`" ;;
    -) $bin --set-brightness "`echo "($cur*(1-$mul))/1" | bc`" ;;
esac
