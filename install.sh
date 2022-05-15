#!/usr/bin/env bash
git clone https://github.com/lassemt/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit

# Get the directory of the currently executing script
DIR=~/.dotfiles;

# Check if loader exist
if [[ ! -f "${DIR}/functions.sh" ]] ; then
  echo "$(tput setaf 1)File ${DIR}/functions.sh is missing, aborting.$(tput sgr0)";
  exit 1;
fi

# Load functions
source "${DIR}/functions.sh";

if ! [ -x "$(command -v stow)" ]; then
  read -r -p "Stow is not installed, install it? (y/n)" installStow 

  if [ "$installStow" != "y" ]; then
    echo_red "Aborting since stow is required."
    exit 1
  fi
fi

read -r -p "Install dependencies? (y/n)" installDependencies
read -r -p "Install applications? (y/n)" installApplications
read -r -p "Configure mac defaults? (y/n)" configureMac 

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ "$installStow" == "y" ]; then
  echo_cyan "Installing stow using brew"
  brew install stow
fi

echo_cyan "Linking dotfiles using stow"
source "${DIR}/link.sh";

if [ "$installDependencies" == "y" ]; then
  echo_cyan "Installing dependencies..."
  source "${DIR}/dependencies.sh";
fi

if [ "$installApplications" == "y" ]; then
  echo_cyan "Installing applications..."
  source "${DIR}/applications.sh";
fi

if [ "$configureMac" == "y" ]; then
  echo_cyan "Setting Macos configuration..."
  source "${DIR}/macos.sh";
fi

echo_green echo "Done. Note that some of these changes require a logout/restart to take effect."