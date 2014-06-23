# User specific environment and startup programs

BOLD=$(tput bold)
RED=$(tput bold; tput setaf 1)
YELLOW=$(tput bold ; tput setaf 3)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
LIGHT_GRAY=$(tput setaf 7)
WHITE=$(tput bold ; tput setaf 7)
RESET_COLOR=$(tput sgr0)

if [ `id -u` == '0' ]; then
    PRIMARY=$RED
else
    # set it to a purple color
    PRIMARY=$(tput setaf 103)
fi

eeojun_virtualenv() {
  if [ x$VIRTUAL_ENV != x ]; then
    if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]; then
      ENV_NAME=`basename "${VIRTUAL_ENV}"`
    else
      folder=`dirname "${VIRTUAL_ENV}"`
      ENV_NAME=`basename "$folder"`
    fi
    echo -n "{$PRIMARY"
    echo -n $ENV_NAME
    echo -n $'\033[00m} '
    # Shell title
    echo -n $'\033]0;venv:'
    echo -n $ENV_NAME
    echo -n $'\007'
  fi
}

eeojun_vcprompt() {
    vcprompt -f "[$PRIMARY%b%m%u$RESET_COLOR] "
}

eeojun_lastcommandfailed() {
    local lc="$BASH_COMMAND" rc=$?
    if [ $rc != 0 ]; then
        echo -n "$PRIMARY[!]$RESET_COLOR last command exited with:"
        echo "$PRIMARY $rc$RESET_COLOR"
    fi
}

PROMPT_COMPONENT="$BOLD\w $PRIMARY>> $RESET_COLOR"
export PS1=$PROMPT_COMPONENT

export PROMPT_COMMAND="eeojun_lastcommandfailed && eeojun_virtualenv && eeojun_vcprompt"
export PS2="$PRIMARY> $RESET_COLOR"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENV_DISTRIBUTE=1
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

# for go
export GOPATH="~/.go/"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/eeojun/.travis/travis.sh ] && source /Users/eeojun/.travis/travis.sh

