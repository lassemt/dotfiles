STOW ?= stow
DIRS ?= git zsh npm
DOTDIR = $(shell pwd)
HOME = /Users/lassemejlvangtvedt
IGNORE = .DS_Store

setup: dependencies config link

link:
	@$(STOW) --target=$(HOME) --ignore=$(IGNORE) -Rv $(DIRS)

dependencies: \
	brew \
	casks \
	./scripts/npm.sh

config: \
	./scripts/macos.sh \
	./scripts/iterm.sh

brew: \
	/usr/local/bin/brew \
	./scripts/brew.sh

/usr/local/bin/brew:
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
	brew analytics off
	
casks: \
	/usr/local/bin/brew \
	./scripts/casks.sh
