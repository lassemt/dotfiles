# LasseMT's dotfiles

## 1. Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## 2. Clone
```
git clone https://github.com/lassemt/dotfiles.git
```
`cd` into directory and call make to bootstrap everything:
```
make
```
Symlink files only
```
make link
```
Download and install tools
```
make dependencies
```
Configure system and set defaults
```
make config
```
