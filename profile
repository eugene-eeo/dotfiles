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
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
