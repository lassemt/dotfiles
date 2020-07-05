#!/usr/bin/env bash

# upgrade all installed packages
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Stow is used in this setup
brew install stow

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh

# Basics
brew install node
brew install git
brew install git-lfs
brew install zsh

# set zsh as your default shell
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

# Tools
brew install aws-elasticbeanstalk
brew install awscli
brew install composer
brew install ffmpeg
brew install wget
brew install youtube-dl
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting
