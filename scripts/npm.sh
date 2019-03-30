#!/usr/bin/env bash

npmdir="${HOME}/.npm-packages"

# Create if folder dont exists
if [ ! -d ${npmdir} ]; then
    mkdir -p ${npmdir}
    npm config set prefix $npmdir
fi

# Set permissions for global modules folder
me=`whoami`
sudo chown -R $me $npmdir

# Install modules
npm install -g n  # node verison manager
npm install -g npm-check-updates  # upgrades package.json dependencies
npm install -g pure-prompt # Pretty, minimal and fast ZSH prompt
