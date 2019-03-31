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

# Init Pure
autoload -U promptinit; promptinit
prompt pure

# Set editor
export PATH=$PATH:$HOME/bin
alias st=subl

# Homebrew's sbin
export PATH="/usr/local/sbin:$PATH"

# Change NPM global folder
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Make mysql cli work with mamp
# export PATH="$PATH:/Applications/MAMP/Library/bin"

# set env variable for tty command
export GPG_TTY=$(tty)

source ~/.iterm2_shell_integration.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
