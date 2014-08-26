BUILD_DIR=~/.bash-files
VIMRC=~/.vimrc
BASHRC=~/.bashrc
GITCONFIG=~/.gitconfig
BASH_PROFILE=~/.bash_profile

all:
	@echo 'tasks:'
	@echo '  source     source the dotfiles'
	@echo '  apply      copy dotfiles'
	@echo '  patch      patch the .bash_profile file'

patch:
	echo '[[ -s ~/.bashrc ]] && source ~/.bashrc' >> $(BASH_PROFILE)

source:
	cp -r $(BUILD_DIR) .
	mv $(BUILD_DIR) ./bash-files
	cp $(VIMRC)     ./vimrc
	cp $(BASHRC)    ./bashrc
	cp $(GITCONFIG) ./gitconfig

apply:
	cp -r ./bash-files $(BUILD_DIR)
	cp ./vimrc     $(VIMRC)
	cp ./bashrc    $(BASHRC)
	cp ./gitconfig $(GITCONFIG)
	brew bundle

.SUFFIXES:
	MAKEFLAGS += -r
