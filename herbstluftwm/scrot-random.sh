#!/bin/sh
mkdir -p ~/screenshots
scrot "$HOME/screenshots/$(date +'%d:%m:%Y-%H:%M:%S').png"
