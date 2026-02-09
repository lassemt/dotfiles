# Created by newuser for 5.5.1

# Detect architecture and set Homebrew prefix
if [[ "$(uname -m)" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi

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

# NPM global folder config
export NPM_PACKAGES="${HOME}/.npm-packages"
export NPM_CONFIG_PREFIX="${HOME}/.npm-packages"
export N_PREFIX="$HOME/.n"

# Consolidated PATH (order matters: first entries take priority)
export PATH="$HOME/.local/bin:$N_PREFIX/bin:$NPM_PACKAGES/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/bin:$HOME/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# GPG TTY for signing
export GPG_TTY=$(tty)

# Homebrew zsh completions and plugins
if [[ -d "$HOMEBREW_PREFIX" ]]; then
    fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
    FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
    [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
        source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
        source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Init Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Aliases
alias st=subl
alias l='ls -FG'
alias ll='ls -FGl'
alias la='ls -FGall'
alias awsfl='aws --profile futures-lab'

# Youtube download aliases
alias yt-mp3='yt-dlp -x --audio-format mp3 -f bestaudio'
alias yt-mp4='yt-dlp -S vcodec:h264,fps,res,acodec:m4a'

# iTerm2 shell integration
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# Helper to fetch secrets from 1Password
env-op() {
    local search="$@"
    keys_string=$(op item get --fields label=username "$search")
    if [[ $? != 0 ]] ; then
        return
    fi
    values_string=$(op item get --reveal --fields label=password "$search")
    read -A keys <<< "$keys_string"
    read -A values <<< "$values_string"
    # If we store "AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY" in the username field
    # and "secret1 secret2" in the password field, we'll map them accordingly.
    # If there are fewer secrets than usernames (space separated), then we'll
    # use the last value for the rest of the secrets mapped to usernames.
    # For example: "GITHUB_TOKEN GITHUB_AUTH_TOKEN" with a password of "foo" will
    # set both environment variables to "foo".
    for ((i = 1 ; i <= $#keys ; i++)) ; do
        if [[ "$values[$i]" != "" ]] ; then
            last_value=$values[$i]
        fi
        export $keys[$i]=$last_value
        >&2 echo "Loaded $keys[$i]"
    done
}

# Deploy static files to lasse.is
deploy_experiment() {
    if [ -z "$1" ]; then
        echo "Error: First argument must be a non-empty string."
        return 1
    fi
    if [ ! -d "$2" ]; then
        echo "Error: Second argument must be a valid directory."
        return 1
    fi
    env-op "AWS_LASSEIS_DIST_ID"
    destination="s3://lasse.is/experimenting/${1}"
    aws s3 sync "$2" "$destination" --delete
    aws cloudfront create-invalidation --distribution-id "$AWS_LASSEIS_DIST_ID" --paths '/*'
}

# Transcribe audio using OpenAI Whisper
transcribe () {
    env-op "OPENAI_API_KEY"
    curl --silent --request POST \
      --url https://api.openai.com/v1/audio/transcriptions \
      --header "Authorization: Bearer $OPENAI_API_KEY" \
      --header 'Content-Type: multipart/form-data' \
      --form file="@$1" \
      --form model=whisper-1 \
      --form response_format=${2:-text}
}

# Translate audio using OpenAI Whisper
translate () {
    env-op "OPENAI_API_KEY"
    curl --silent --request POST \
      --url https://api.openai.com/v1/audio/translations \
      --header "Authorization: Bearer $OPENAI_API_KEY" \
      --header 'Content-Type: multipart/form-data' \
      --form file="@$1" \
      --form model=whisper-1 \
      --form response_format=${2:-text}
}

# Extract audio from video
extract_audio () {
    echo "Extracting audio from $1"
    filename=${1##*/}
    filename=${filename%.*}
    ffmpeg -i "$1" -ar 16000 -ac 1 -c:a pcm_s16le "$filename.wav"
    echo "Saved audiofile $filename.wav"
}

# Apply subtitles to video
apply_srt () {
    echo "Add subtitles $2 to $1"
    filename=${1##*/}
    extension="${filename##*.}"
    filename="${filename%.*}"
    ffmpeg -i "$1" -vf subtitles="$2" "$filename-subs.$extension"
    echo "Saved video with subs $filename-subs.$extension"
}

# Compress screen recording to mp4
compress_screencapture() {
    if [[ -z "$1" ]]; then
        echo "Usage: compress_screencapture input.mov [output.mp4]"
        return 1
    fi
    infile="$1"
    outfile="${2:-${infile%.mov}.mp4}"
    ffmpeg -i "$infile" -vcodec h264 -acodec aac "$outfile"
}

# Extract poster frame from video
get_poster() {
    if [[ -z "$1" ]]; then
        echo "Usage: get_poster input.mov [output.png]"
        return 1
    fi
    infile="$1"
    outfile="${2:-${infile%.*}.png}"
    ffmpeg -y -i "$infile" -vframes 1 -q:v 2 "$outfile"
}

# nmp secrets tool
if [[ "$(uname -m)" == "arm64" ]]; then
    alias nmp-secrets="${HOME}/nmp-tools/secret_2.4.5_darwin_arm64"
else
    alias nmp-secrets="${HOME}/nmp-tools/secret_2.4.5_darwin_amd64"
fi
[[ -x "$(command -v nmp-secrets)" ]] && eval "$(nmp-secrets completion zsh)"

# Claude Code configuration
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION="europe-west1"
export ANTHROPIC_VERTEX_PROJECT_ID="smp-pc-ai-unit-vertex-ai"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
CONDA_BASE="$HOMEBREW_PREFIX/Caskroom/miniconda/base"
__conda_setup="$("$CONDA_BASE/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_BASE/etc/profile.d/conda.sh" ]; then
        . "$CONDA_BASE/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_BASE/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Create x86 conda environment
# example usage: create_x86_conda_environment myenv_x86 python=3.9
create_x86_conda_environment () {
    CONDA_SUBDIR=osx-64 conda create -n $@
    conda activate $1
}

# Create ARM conda environment
# example usage: create_ARM_conda_environment myenv_arm python=3.9
create_ARM_conda_environment () {
    CONDA_SUBDIR=osx-arm64 conda create -n $@
    conda activate $1
}

# Terraform completion
autoload -U +X bashcompinit && bashcompinit
[[ -x "$HOMEBREW_PREFIX/bin/terraform" ]] && complete -o nospace -C "$HOMEBREW_PREFIX/bin/terraform" terraform

# Initialize zsh completions
autoload -Uz compinit
compinit -u
