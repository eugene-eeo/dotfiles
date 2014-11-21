#!/bin/bash
if [[ `id -u` == '0' ]]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi


__color() {
    echo "\[$(tput $@)\]"
}


: ${GREY=`__color setaf 238`}
: ${RESET=`__color sgr0`}

set_prompt() {
    PS1="`vcprompt -f \"${GREY}(%b)${RESET}\"` \[\033[38;5;240m\][\[\e[0m\]\[\e[38;5;202m\]\w\[\e[38;5;240m\]]$\[\e[0m\] "
}

PROMPT_COMMAND='set_prompt'
