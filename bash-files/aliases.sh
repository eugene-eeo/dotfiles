alias tree='tree -F -C -I "*.pyc|__pycache__"'
alias tk='toolkit'
alias ls='ls -G'

pushd_to_devnull() {
    pushd $1 > /dev/null
}

alias cd=pushd_to_devnull
