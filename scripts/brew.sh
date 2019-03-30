#!/usr/bin/env bash

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

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

brew tap caskroom/cask

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json webpquicklook suspicious-package quicklookase qlvideo 

# Browsers
brew cask install google-chrome
brew cask install firefox

# Other software
brew cask install 1password
brew cask install docker
brew cask install sublime-text
brew cask install iterm2
brew cask install dropbox
brew cask install adobe-creative-cloud
brew cask install suitcase-fusion
brew cask install discord
brew cask install sketch
brew cask install spotify
brew cask install zeplin

# GPG Tools
# brew cask install gpg-suite
