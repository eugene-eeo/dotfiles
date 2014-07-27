#!/bin/bash

alias tree='tree -F -C -I "*.pyc|__pycache__|*.pyo"'
alias json='python -m json.tool'
alias ls='ls -G'
alias du='du -h'
alias procview='ps -eo pcpu,pid,user,args | sort -rk 1 | head -6'
alias sql='sqlite3'

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

lineprint() {
    local counter=0;
    while read line;
    do
        counter=$[$counter +1]
        if [[ $counter == $1 ]]; then
            echo -e "\e[48;5;247m\e[38;5;234m $counter \e[0m $line";
            continue;
        fi
        echo -e "\e[48;5;235m \e[38;5;247m$counter \e[0m $line";
    done
}
