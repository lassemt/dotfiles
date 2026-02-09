#!/usr/bin/env bash

# upgrade all installed packages
brew upgrade

# Install dependencies
brew install \
	asimov \
	awscli \
	c2patool \
	cmake \
	composer \
	coreutils \
	ddev/ddev/ddev \
	exiftool \
	ffmpeg \
	git \
	git-lfs \
	gnupg \
	go \
	grep \
	hashicorp/tap/terraform \
	highlight \
	imagemagick \
	jq \
	kubernetes-cli \
	openssh \
	pinentry-mac \
	s3cmd \
	stow \
	tree \
	uv \
	vim \
	wget \
	yt-dlp \
	zsh \
	zsh-autosuggestions \
	zsh-completions \
	zsh-syntax-highlighting \
	1password-cli

# set zsh as your default shell
sudo sh -c "echo $(which zsh) >> /etc/shells"
sudo chsh -s $(which zsh)

# instruct Homebrew to automatically load the scheduled job, ensuring Asimov is being run automatically every day:
# TODO: This might have some problems
sudo brew services start asimov

#
# Fix npm global path
#
# Based on
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
npmdir="${HOME}/.npm-packages"

# Create if folder dont exists
if [ ! -d ${npmdir} ]; then
    mkdir -p ${npmdir}
    npm config set prefix $npmdir
fi

# Set permissions for global modules folder
# me=`whoami`
# sudo chown -R $me $npmdir

# Install NPM dependencies
npm install -g @anthropic-ai/claude-code  # Claude AI CLI
npm install -g http-server  # Simple static HTTP server
npm install -g n  # node version manager
npm install -g npm-check-updates  # upgrades package.json dependencies
npm install -g pure-prompt  # Pretty, minimal and fast ZSH prompt
