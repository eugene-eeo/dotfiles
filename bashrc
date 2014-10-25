if [[ `id -u` == '0' ]]; then
    echo -e '\033[31mYou are in sudo mode!\033[0m'
fi

if [ -f $(brew --prefix)/etc/bash_completion.d ]; then
    source $(brew --prefix)/etc/bash_completion.d
fi

source ~/.bash-files/completions/index.sh
source ~/.bash-files/aliases.sh
source ~/.bash-files/config.sh
source ~/.bash-files/exports.sh
