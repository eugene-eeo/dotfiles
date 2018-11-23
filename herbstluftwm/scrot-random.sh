#!/bin/sh
mkdir -p ~/screenshots
scrot "$HOME/screenshots/$(date +'%H:%M:%S-%d:%m:%Y').png"
