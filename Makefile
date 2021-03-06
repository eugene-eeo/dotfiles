sync:
	mkdir -p ~/.config/dunst
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
	cp    ./herbstluftwm/* ~/.config/herbstluftwm
	cp    ./dunstrc        ~/.config/dunst/dunstrc
	cp    ./hydrarc.json   ~/.hydrarc.json
	cp    ./compton.conf   ~/.compton.conf

bins:
	cd st && make DESTDIR=~/.scripts/ clean install
	# cd get-volume && make

slouch:
	touch ~/.config/slouch/hooks
	cp ~/code/slouch/slouch ./scripts/

reload: slouch sync
	-killall dunst
	-herbstclient reload

push:
	git push origin


all: sync bins slouch
