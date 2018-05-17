#!/usr/bin/bash
# homebrew
export PATH="$HOME/.go-packages/bin:$HOME/.cargo/bin:$HOME/.scripts:/usr/local/bin:${PATH}"
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export GOPATH="$HOME/.go-packages"
source ~/.session-keys

export CLICOLOR=1
export IGNOREEOF=1

export LESS='-S -R'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

RESET="\\[$(tput sgr0)\\]"
DIM="\\[$(tput setaf 2)\\]"
RED="\\[$(tput setaf 4)\\]"

function __virtualenv_info {
    [ "$VIRTUAL_ENV" ] && printf "[${VIRTUAL_ENV##*/}] "
}

export PROMPT_DIRTRIM=2
export PS1=" ${RED}\$(__virtualenv_info)${RESET}\w\$(vcprompt -f '${RED}(%b${DIM}%m${RED})')${RESET} ${RED}$ ${RESET}"
export PS2=" > "

# Python options
export PYTHONIOENCODING='utf-8'
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONDONTWRITEBYTECODE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Use neovim as editor
export EDITOR='nvim'
export VISUAL='nvim'
export HOMEBREW_EDITOR='nvim'
alias vimdiff='nvim -d'
alias vim='nvim'

alias rmv='rmvirtualenv'
alias mkv='mkvirtualenv'

alias t='tree -N -F -C -I "$(cat .gitignore ~/.gitignore_global | egrep -v "^#.*$|^[[:space:]]*$" | tr "\\n" "|")"'
alias g='git'

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

h() {
    local _FZF
    _FZF=$(history | sed 's/^ *[0-9]* *//' | fzf)
    if [ "$_FZF" ]; then
        $_FZF
    fi
}

mux() {
    tmux attach -t base || tmux new -s base
}

youtube-mp3() {
    youtube-dl --extract-audio --audio-format mp3 $@
}

# Rust completion
export RUST_SRC_PATH="$HOME/sources/rust/src/"

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . $(brew --prefix)/etc/bash_completion
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper
