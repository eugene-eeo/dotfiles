#!/bin/bash

alias tree='tree -F -C -I "*.pyc|__pycache__|*.pyo"'
alias json='python -m json.tool'
alias tk='toolkit'
alias ls='ls -G'
alias du='du -h'
alias ttyclock='tty-clock -cC 7'
alias procview='ps -eo pcpu,pid,user,args | sort -rk 1 | head -6'

cd() {
    pushd $@ > /dev/null
}

venv() {
    if [[ x$VIRTUAL_ENV != x ]]; then
        basename $VIRTUAL_ENV
    fi
}

mkenv() {
    mkvirtualenv "$@"
}

rmenv() {
    rmvirtualenv "$@"
}
