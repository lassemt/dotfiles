STOW ?= stow
DIRS ?= git zsh
DOTDIR = $(shell pwd)
HOME = /Users/lassemejlvangtvedt
IGNORE = .DS_Store

setup: dependencies config link restart

link:
	@$(STOW) --target=$(HOME) --ignore=$(IGNORE) -Rv $(DIRS)

dependencies:
	./scripts/brew.sh
	./scripts/casks.sh
	./scripts/npm.sh

config:
	./scripts/macos.sh
	./scripts/iterm.sh

restart:
	./scripts/restart.sh