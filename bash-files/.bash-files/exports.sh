#!/bin/bash
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS='Exxxxxxxxxxxxxxxxxxxxx'

export LESS='-er'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export EDITOR=vim
export OLDPWD=`pwd`

export GOPATH="$HOME/.go/"
export GOPATH="$HOME/gophers"
export GOBIN="$HOME/gophers-bin"

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export VISUAL=vim
export FIGNORE=".git|.svn|.hg"

export HISTCONTROL=erasedups
export HISTSIZE=1000

export PATH="$HOME/.scripts:$PATH"

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -f "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"

set PYTHONIOENCODING=utf-8
set -o vi
