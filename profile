#!/usr/bin/bash
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export GOPATH="$HOME/go"

# Python options
export PYTHONIOENCODING='utf-8'
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONDONTWRITEBYTECODE=1

# Use neovim as editor
export EDITOR='nvim'
export VISUAL='nvim'

export PYENV_ROOT="$HOME/.pyenv/"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if [ "$(hostname)" = box ]; then
    export PATH="/usr/local/sbin:/usr/sbin:$PATH"
    export PATH="/usr/lib/go-1.23/bin:$PATH"
fi
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
