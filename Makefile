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
	# cp    ./vimrc          ~/.config/nvim/init.vim

bins:
	cd st && make DESTDIR=~/.scripts/ clean install

# slouch:
# 	touch ~/.config/slouch/hooks
# 	cp ~/code/slouch/slouch ./scripts/

# reload: slouch sync
# 	-killall dunst
# 	-herbstclient reload

push:
	git push origin

# all: sync bins slouch
all: sync bins
