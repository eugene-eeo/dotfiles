if [ `id -u` == '0' ]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi

BACKGROUND="\[\033[48;5;236m\]"
GREEN="\[\033[38;5;192m\]"
ORANGE="\[\033[38;5;208m\]"
YELLOW="\[\033[38;5;221m\]"
GREY="\[\033[38;5;241m\]"
RESET="\[\033[0m\]"

VCPROMPT="\`vcprompt -f '$BACKGROUND $YELLOW%b$ORANGE%m%u $RESET '\`"

export PS1="$VCPROMPT$GREY[ $RESET\w $GREY]$YELLOW\$$RESET "
export PS2="${GREEN}> ${RESET}"

