#!/bin/bash

alias tree='tree -F -C -I "*.pyc|__pycache__|*.pyo"'
alias tk='toolkit'
alias ls='ls -G'

cd() {
    pushd $@ > /dev/null
}

venv() {
    if [[ x$VIRTUAL_ENV != x ]]; then
        basename $VIRTUAL_ENV
    fi
}

todo() {
    local contents=`cat '~/.todo.md'`
    if [[ $? == 0 ]]; then
        echo $contents
    fi
}
