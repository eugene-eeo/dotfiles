export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS='Exxxxxxxxxxxxxxxxxxxxx'

export LESS='-er'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export EDITOR=vim
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENV_DISTRIBUTE=1
export OLDPWD=$HOME

export GOPATH="~/.go/"
export GOPATH="/Users/eeojun/gophers"
export GOBIN="/Users/eeojun/gophers-bin"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export FIGNORE=".git|.svn"

export HISTCONTROL=erasedups
export HISTSIZE=1000

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

[ -f /Users/eeojun/.travis/travis.sh ] && source /Users/eeojun/.travis/travis.sh

set PYTHONIOENCODING=utf-8
set -o vi
