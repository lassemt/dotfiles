#!/usr/bin/env bash

# Download iterm shell integrattion for zsh
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# Install the Solarized Dark theme for iTerm
open "${HOME}/themes/Snazzy.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
