if [ `id -u` == '0' ]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi

export PS1=' 🌀  '
#export PS1=' ༄	 '
export PS2="\[\e[38;5;27m\]--> \[\e[0m\]"

