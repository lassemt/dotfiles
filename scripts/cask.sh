#!/usr/bin/env bash

# tap homebrew-cask to install other osx related stuff
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
