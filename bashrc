#!/usr/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=11000
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
    PS1="${RESET} ${py}\\w${vc} ${RED}\$${RESET} "
}

export PROMPT_DIRTRIM=3
export PROMPT_COMMAND=set_bash_prompt
export PS2=" ${DIM}>${RESET} "

alias t='rg --ignore --files | tree'
alias g='git'
alias ls='ls --color=auto'
alias pbcopy='xsel -ib'
alias pbpaste='xsel -ob'
alias sudo='sudo '
alias vim='nvim'

# Use rg to pipe to FZF, so we respect .gitignore
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob=!.git/'
export FZF_DEFAULT_OPTS='--preview-window=border-sharp'

v() {
    if [ "$1" ]; then
        nvim "$@"
        return
    fi
    local _FZF
    if _FZF=$(fzf --preview='head -100 {}'); then
        nvim "$_FZF"
    fi
}

open() {
    pdetach xdg-open "$@"
}

tclear() {
    tmux clear
    clear
}

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Direnv
eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
