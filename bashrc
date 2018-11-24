#!/usr/bin/bash
export CLICOLOR=1
export IGNOREEOF=1

export LESS='-S -R'
export GREP_COLOR='1;32'

RESET="\\[$(tput sgr0)\\]"
DIM="\\[$(tput setaf 2)\\]"
RED="\\[$(tput setaf 4)\\]"

export PROMPT_DIRTRIM=2
export PS1=" \w\$(vcprompt -f '${RED}(%b${DIM}%m${RED})')${RESET} ${RED}$ ${RESET}"
export PS2=" ${DIM}>${RESET} "

alias t='tree -N -F -C'
alias g='git'
alias ls='ls --color=auto'
alias pbcopy='xsel -ib'
alias pbpaste='xsel -ob'
alias u='urxvt &'

# Use ag to pipe to FZF, so we respect .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'

v() {
    if [ "$1" ]; then
        vim "$@"
        return
    fi
    local _FZF
    _FZF=$(fzf --preview='cat {}')
    if [ "$_FZF" ]; then
        vim "$_FZF"
    fi
}

mux() {
    tmux attach -t base || tmux new -s base
}

youtube-mp3() {
    youtube-dl --extract-audio --audio-format mp3 $@
}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
