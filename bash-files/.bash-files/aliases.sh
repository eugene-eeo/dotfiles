alias tree='tree -F -C -I "*.pyc|__pycache__"'
alias tk='toolkit'
alias ls='ls -G'

cd() {
    pushd $@ > /dev/null
    echo -e "\033[1;30m`pwd`\033[0m"
}

alias venv='basename $VIRTUAL_ENV'
