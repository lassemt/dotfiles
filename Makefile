STOW ?= stow
DIRS ?= git ssh zsh
DOTDIR = $(shell pwd)
HOME = /Users/lassemt
IGNORE = .DS_Store

setup: dependencies config link

link:
	@$(STOW) --target=$(HOME) --ignore=$(IGNORE) -Rv $(DIRS)

dependencies:
	./scripts/brew.sh
	./scripts/npm.sh
	./scripts/other.sh

config:
	./scripts/terminfo.sh
	./scripts/macos.sh
