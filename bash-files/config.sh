#!/bin/bash
if [[ `id -u` == '0' ]]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi


__color() {
    echo "\[$(tput $@)\]"
}


: ${BLUE=`__color setaf 63`}
: ${ORANGE=`__color setaf 214`}
: ${GREY=`__color setaf 238`}
: ${RESET=`__color sgr0`}

set_prompt() {
    PS1="${GREY}$(vcprompt -f [${BLUE}%b${GREY}]) ${RESET}\w ${BLUE}»${RESET} "
}

PROMPT_COMMAND='set_prompt'
