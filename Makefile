sync:
	chmod a+x scripts/*
	cp    ./gitconfig      ~/.gitconfig
	cp    ./tmux.conf      ~/.tmux.conf
	cp    ./bashrc         ~/.bashrc
	cp    ./profile        ~/.profile
	cp    ./bash_profile   ~/.bash_profile
	cp    ./pythonrc.py    ~/.pythonrc.py
	cp    ./inputrc        ~/.inputrc
	cp -a ./scripts/.      ~/.scripts
	cp -R ./nvim           ~/.config

bins:
	cd st && make DESTDIR=~/.scripts/ clean install

push:
	git push origin

all: sync bins
