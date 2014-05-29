if [ -f ~/.bashrc ]; then
 . ~/.bashrc
fi
 
# User specific environment and startup programs

RED=$(tput setaf 1)
YELLOW=$(tput bold ; tput setaf 3)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
LIGHT_GRAY=$(tput setaf 7)
WHITE=$(tput bold ; tput setaf 7)
RESET_COLOR=$(tput sgr0)
 
PS1='\[$WHITE\]\w \[$YELLOW\]NEW\[$GREEN\]\n\[$GREEN\]\$\[$RESET_COLOR\] '
export SUDO_PS1="\[$WHITE\]\w \[$YELLOW\]NEW\[\e[0;31m\]\n#\[$RESET_COLOR\] "

# for go
export GOPATH="~/.go/"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/eeojun/.travis/travis.sh ] && source /Users/eeojun/.travis/travis.sh
