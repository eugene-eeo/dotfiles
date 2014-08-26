if [ `id -u` == '0' ]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi

#export PS1=' 🌀  '
#export PS1=" \[\e[38;5;18m\]>\[\e[38;5;19m\]>\[\e[38;5;20m\]>\[\e[0m\] "
#export PS1=" \[\e[38;5;238m\][\[\e[38;5;243m\]\w\[\e[38;5;238m\]] \[\e[38;5;24m\]$\[\e[0m\] "
export PS1=" \[\e[38;5;24m\]$\[\e[0m\] "
export PS2=" \[\e[38;5;239m\]>\[\e[0m\] "
