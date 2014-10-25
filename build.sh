#!/bin/bash
GREY=$(tput setaf 239)
GREEN=$(tput setaf 2);
RESET=$(tput sgr 0);


echo "Copying ~/.bash-files ${GREY}-> ${GREEN}bash-files${RESET}"
if [ -d './bash-files' ]; then
    rm -r bash-files
fi
cp -r ~/.bash-files .
mv .bash-files bash-files

declare -a FILES=(bashrc vimrc tmux.conf gitconfig bash_profile)
for file in "${FILES[@]}"; do
    echo "Copying ~/.$file ${GREY}-> ${GREEN}$file${RESET}"
    cp ~/.$file .
    mv .$file $file
done
