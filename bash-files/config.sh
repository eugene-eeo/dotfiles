BOLD=$(tput bold)
RED=$(tput bold; tput setaf 1)
YELLOW=$(tput bold ; tput setaf 3)
GREEN=$(tput setaf 148)
LIGHT_GRAY=$(tput setaf 7)
WHITE=$(tput bold ; tput setaf 7)
RESET_COLOR=$(tput sgr0)

if [ `id -u` == '0' ]; then
    PRIMARY=$RED
else
    # set it to a purple color
    PRIMARY=$(tput setaf 103)
fi

prompt_char() {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

eeojun_virtualenv() {
    if [ x$VIRTUAL_ENV != x ]; then
        if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]; then
            local ENV_NAME=`basename "${VIRTUAL_ENV}"`
        else
            local folder=`dirname "${VIRTUAL_ENV}"`
            local ENV_NAME=`basename "$folder"`
        fi
        echo -n "($PRIMARY"
        echo -n $ENV_NAME
        echo -n $'\033[00m) '
        # Shell title
        echo -n $'\033]0;venv:'
        echo -n $ENV_NAME
        echo -n $'\007'
    fi
}

eeojun_vcprompt() {
    vcprompt -f "[$PRIMARY%b$GREEN%m%u$RESET_COLOR] "
}

eeojun_lastcommandfailed() {
    local rc=$?
    if [ $rc != 0 ]; then
        echo -n "$PRIMARY[!]$RESET_COLOR last command exited with:"
        echo "$PRIMARY $rc$RESET_COLOR"
    fi
}

PROMPT_COMPONENT="$BOLD\w $PRIMARY>> $RESET_COLOR"
export PS1=$PROMPT_COMPONENT

export PROMPT_COMMAND="eeojun_lastcommandfailed && eeojun_virtualenv && eeojun_vcprompt"
export PS2="$PRIMARY> $RESET_COLOR"

