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

fpath+=("$(brew --prefix)/share/zsh/site-functions")

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
alias awsfl='aws --profile futures-lab'

# Youtube download mp3 alias
alias yt-mp3='youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg'
alias yt-mp4='youtube-dl -f best'

# msdfgen installed via msdf-bmfont-xml
alias msdfgen="${HOME}/.npm-packages/lib/node_modules/msdf-bmfont-xml/bin/darwin/msdfgen.osx"

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Change NPM global folder
export NPM_PACKAGES="${HOME}/.npm-packages"
export NPM_CONFIG_PREFIX="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# set env variable for tty command
export GPG_TTY=$(tty)

source "${HOME}/.iterm2_shell_integration.zsh"
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  autoload -Uz compinit
  compinit -u
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

