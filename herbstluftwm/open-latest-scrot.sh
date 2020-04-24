#!/bin/bash
latest() {
    find "$HOME/Pictures/" -maxdepth 1 -type f \
        | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]+\.png$' \
        | sort -r \
        | head -n 1
}

xdg-open "$(latest)"
