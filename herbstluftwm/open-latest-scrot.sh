#!/bin/bash
latest() {
    # shellcheck disable=2010
    ls ~/Pictures/ \
        | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]+\.png' \
        | sort -r \
        | head -n 1
}

xdg-open "$HOME/Pictures/$( latest )"
