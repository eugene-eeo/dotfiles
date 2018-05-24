sync:
	chmod a+x scripts/*
	cp    ./gitconfig         ~/.gitconfig
	cp    ./tmux.conf         ~/.tmux.conf
	cp    ./bash_profile      ~/.bash_profile
	cp    ./pythonrc.py       ~/.pythonrc.py
	cp    ./inputrc           ~/.inputrc
	cp    ./vimrc             ~/.config/nvim/init.vim
	cp -R ./dotvim/           ~/.config/nvim/
	cp -R ./scripts/          ~/.scripts/
	cp    ./login.sh          ~/login.sh
	cp    ./phoenix.js        ~/.phoenix.js

override:
	cp     ~/.inputrc              ./inputrc
	cp     ~/.gitconfig            ./gitconfig
	cp     ~/.tmux.conf            ./tmux.conf
	cp     ~/.config/nvim/init.vim ./vimrc
	cp     ~/.bash_profile         ./bash_profile
	cp -R  ~/.config/nvim          ./dotvim/
	cp -R  ~/.scripts/             ./scripts/
	cp     ~/.pythonrc.py          ./pythonrc.py
	rm -rf ./dotvim/undo/
	rm -rf ./dotvim/plugged/
	rm -rf ./dotvim/.netrwhist
