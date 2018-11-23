sync:
	chmod a+x scripts/*
	cp    ./gitconfig      ~/.gitconfig
	cp    ./tmux.conf      ~/.tmux.conf
	cp    ./bashrc         ~/.bashrc
	cp    ./profile        ~/.profile
	cp    ./bash_profile   ~/.bash_profile
	cp    ./pythonrc.py    ~/.pythonrc.py
	cp    ./inputrc        ~/.inputrc
	cp    ./vimrc          ~/.config/nvim/init.vim
	cp -a ./dotvim/.       ~/.config/nvim/
	cp -a ./scripts/.      ~/.scripts/

push:
	git push origin
