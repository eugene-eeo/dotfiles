#!/usr/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

export CLICOLOR=1
export IGNOREEOF=1

export LESS='-S -R'
export GREP_COLOR='1;32'

RESET="\\[$(tput sgr0)\\]"
DIM="\\[$(tput setaf 2)\\]"
RED="\\[$(tput setaf 4)\\]"

export PROMPT_DIRTRIM=2
export PS1=" \w\$(vcprompt -f '${RED}(%b${DIM}%m${RED})')${RESET} ${RED}\$ ${RESET}"
export PS2=" ${DIM}>${RESET} "
export PROMPT_COMMAND='echo -ne "\033]0;[st] ${USER}: $PWD\007"'

alias t='tree -N -F -C'
alias g='git'
alias ls='ls --color=auto'
alias pbcopy='xsel -ib'
alias pbpaste='xsel -ob'
alias u='pdetach st'
alias hc='herbstclient'

# Use ag to pipe to FZF, so we respect .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'

v() {
    if [ "$1" ]; then
        vim "$@"
        return
    fi
    local _FZF
    if _FZF=$(fzf --preview='cat {}'); then
        vim "$_FZF"
    fi
}

open() {
    pdetach xdg-open "$@"
}

mux() {
    tmux attach -t base || tmux new -s base
}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [ -n "$DESKTOP_SESSION" ]; then
    #shellcheck disable=2046
    export $(gnome-keyring-daemon --start --components=ssh,gpg,secrets,pkcs11)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
