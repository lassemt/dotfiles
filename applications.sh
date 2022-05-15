#!/usr/bin/env bash

brew install --cask \
	1password \
	adobe-creative-cloud \
	android-file-transfer \
	blender \
	discord \
	docker \
	dropbox \
	firefox \
	fontbase \
	google-chrome \
	iterm2 \
	miniconda \
	opera \
	qlcolorcode \
	qlimagesize \
	qlmarkdown \
	qlstephen \
	qlvideo \
	quicklook-json \
	quicklookase \
	sequel-ace \
	slack \
	spotify \
	sublime-text \
	suspicious-package \
	the-unarchiver \
	transmission \
	webpquicklook \
	zxpinstaller

# To remove the quarantine flag from 
# an unnotarized QuickLook plugin
# https://hargitai.co.nz/quicklook-plugin-qlgenerator-cant-be-opened-because-apple-cannot-check-it-for-malicious-software-fix-locally/
sudo xattr -cr ${HOME}/Library/QuickLook/*.qlgenerator

# Link sublime preferences
# Remove files that we want to replace with symlinks
FILES="sublime/*"
for file in $FILES
do
	filename=$(basename "$file")
	# 3. Check if ~/bin/script is a symlink.
	if [[ ! -L "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/$filename" ]]; then
	  echo "Removing $filename"
	  rm "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/$filename"
	fi
done

stow \
	--target=${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/User \
	--ignore=.DS_Store \
	-Rv sublime

# iTerm config
# Download iterm shell integrattion for zsh
curl -L https://iterm2.com/shell_integration/zsh \
-o ${HOME}/.iterm2_shell_integration.zsh

# Install the Solarized Dark theme for iTerm
open "iterm/Snazzy.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false