#!/usr/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

export CLICOLOR=1
export IGNOREEOF=1

export LESS='-SR'

RESET="\\[$(tput sgr0)\\]"
DIM="\\[$(tput dim)\\]"
GREEN="\\[$(tput setaf 2)\\]"
RED="\\[$(tput setaf 4)\\]"

# Prompt function
set_bash_prompt() {
    local vc
    local py
    vc=$(vcprompt -f "${RED}(%b${GREEN}%m${RED})${RESET}")
    py=$PYENV_VERSION
    if [ -n "$py" ] && [ "$py" != "system" ]; then
        py="${DIM}($py)${RESET} "
    else
        py=""
    fi
    PS1="${RESET} $py\\w${vc} ${RED}\$${RESET} "
}

export PROMPT_DIRTRIM=3
# export PS1=" \\w\$(vcprompt -f '${RED}(%b${GREEN}%m${RED})')${RESET} ${RED}\$${RESET} "
export PROMPT_COMMAND=set_bash_prompt
export PS2=" ${DIM}>${RESET} "

alias t='tree -v -a -I .git'
alias g='git'
alias ls='ls --color=auto'
alias pbcopy='xsel -ib'
alias pbpaste='xsel -ob'
alias u='pdetach st'
alias hc='herbstclient'
alias sudo='sudo '

# Use rg to pipe to FZF, so we respect .gitignore
export FZF_DEFAULT_COMMAND='rg --files'

v() {
    if [ "$1" ]; then
        vim "$@"
        return
    fi
    local _FZF
    if _FZF=$(fzf --preview='head -100 {}'); then
        vim "$_FZF"
    fi
}

open() {
    pdetach xdg-open "$@"
}

# mux() {
#     local session="${1:-base}"
#     tmux attach -t "$session" || tmux new -s "$session"
# }

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# source fzf if it exists
#shellcheck disable=1090
[ -s "$HOME/.fzf.bash" ] && \. "$HOME/.fzf.bash"

eval "$(pyenv init -)"
