#!/usr/bin/env bash

# upgrade all installed packages
brew upgrade

# Instll dependencies
brew install \
	asimov \
	aws-elasticbeanstalk \
	awscli \
	composer \
	coreutils \
	craftcms/nitro/nitro \
	ffmpeg \
	git \
	git-lfs \
	gnupg \
	grep \
	mysql \
	node \
	openssh \
	s3cmd \
	stow \
	vim \
	wget \
	youtube-dl \
	zsh \
	zsh-autosuggestions \
	zsh-completions \
	zsh-syntax-highlighting

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
npm install -g n  # node verison manager
npm install -g npm-check-updates  # upgrades package.json dependencies
npm install -g pure-prompt # Pretty, minimal and fast ZSH prompt
