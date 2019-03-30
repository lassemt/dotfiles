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
brew install screen


# Basics
brew install git
brew install git-lfs
brew install zsh

# set zsh as your default shell
sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh

# Tools
brew install tree                             # List dirs as tree graphs
brew install wget                             # Download stuff from the web
brew install youtube-dl                       # Download videos
brew install prettyping                       # Nicer ping command
brew install python3                          # Python
brew install composer                         # PHP Package manager
brew install zsh-autosuggestions              # ZSH autosuggestions
brew install zsh-completions                  # ZSH compleytes
brew install zsh-syntax-highlighting          # ZSH syntax highlightning
