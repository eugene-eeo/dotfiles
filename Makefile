BUILD_DIR=~/.bash-files
VIMRC=~/.vimrc
BASHRC=~/.bashrc
GITCONFIG=~/.gitconfig

all:
	@echo 'tasks:'
	@echo '  source     source the dotfiles'
	@echo '  apply      copy dotfiles'

source:
	cp -r $(BUILD_DIR) ./bash-files
	cp $(VIMRC)     ./vimrc
	cp $(BASHRC)    ./bashrc
	cp $(GITCONFIG) ./gitconfig

apply:
	cp -r ./bash-files $(BUILD_DIR)
	cp ./vimrc     $(VIMRC)
	cp ./bashrc    $(BASHRC)
	cp ./gitconfig $(GITCONFIG)

.SUFFIXES:
	MAKEFLAGS += -r
