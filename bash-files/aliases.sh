#!/bin/bash

alias g='git'
alias tree='tree -F -C -I "*.pyc|__pycache__|*.pyo"'
alias json='python -m json.tool'
alias ls='ls -G'
alias du='du -h'
alias procview='ps -eo pcpu,pid,user,args | sort -rk 1 | head -6'
alias sql='sqlite3'

alias chrome="open $HOME/Applications/Google\ Chrome.app"
alias kakao="open /Applications/KakaoTalk.app"

cd() {
    pushd $@ > /dev/null
}

hfind() {
    history | grep --color=always $1 | sed '$ d'
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
