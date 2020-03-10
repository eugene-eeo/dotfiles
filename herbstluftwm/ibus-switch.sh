#!/bin/sh
case "$(ibus engine)" in
    'xkb:us::eng') ibus engine pinyin ;;
    'pinyin')      ibus engine xkb:us::eng ;;
esac
herbstclient emit_hook ibus
