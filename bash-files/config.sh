#!/bin/bash
if [[ `id -u` == '0' ]]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi


WHITE=$(tput setaf 231)
GREEN=$(tput setaf 148)
DARK=$(tput setaf 64)
RESET=$(tput sgr0)

export PS1="\[$WHITE\]λ \w \$(vcprompt -f '\[$DARK\]|\[$GREEN\]%b\[$DARK\]| ')\[$RESET\]"
