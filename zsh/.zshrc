# Created by newuser for 5.5.1

# History config
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

## Expansion and globbing
setopt    glob
unsetopt  case_glob
unsetopt  case_match

# Init Pure
autoload -U promptinit; promptinit
prompt pure

# Set editor
export PATH=$PATH:$HOME/bin
alias st=subl

# aliases
alias l='ls -FG'
alias ll='ls -FGl'
alias la='ls -FGall'

# Youtube download mp3 alias
alias yt-mp3='youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg'
alias yt-mp4='youtube-dl -f best'

# alias msdfgen='${HOME}/Sparetime/Experiments/msdfgen/dist/msdfgen'

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Change NPM global folder
export NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Make mysql cli work with mamp
# export PATH="$PATH:/Applications/MAMP/Library/bin"

# set env variable for tty command
export GPG_TTY=$(tty)

# Add python to path
# export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH"

# Add postgres to path
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Anaconda
# export PATH="/usr/local/anaconda3/bin:$PATH"

# Add msdfgen 
# export PATH="${HOME}/Sparetime/Experiments/msdfgen/dist:$PATH"

# if type brew &>/dev/null; then
# 	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
# 	autoload -Uz compinit
# 	compinit
# fi

source ~/.iterm2_shell_integration.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

