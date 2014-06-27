if [ `id -u` == '0' ]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi

GREEN="\[\033[38;5;107m\]"
GREY="\[\033[38;5;241m\]"
RESET="\[\033[0m\]"

export PS1="${GREEN}\u@\h ${GREY}>${RESET} "
export PS2="$PRIMARY> $RESET_COLOR"

