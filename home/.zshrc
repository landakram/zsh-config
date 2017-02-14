
source ~/.secrets.zsh

bindkey -e

setopt correctall

# Z configuration
. `brew --prefix`/etc/profile.d/z.sh

# Show selected item in tab completion
zstyle ':completion:*' menu select

# Let alt-backspace delete to slashes, which is more consistent with
# fish's behavior
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

export VIRTUAL_ENV_DISABLE_PROMPT=1
# virtualenv configuration
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/Cellar/python/2.7.12_2/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh

function virtualenv_info { [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') ' }

export GOPATH=$HOME/go

export PATH=/Users/mark/Library/Android/sdk/tools:$PATH
export PATH=/Users/mark/Library/Android/sdk/platform-tools:$PATH
export PATH=/usr/local/bin/libimobiledevice:$PATH
export PATH=/usr/local/opt/gettext/bin:$PATH
export PATH=/Users/mark/.cabal/bin:$PATH
export PATH=/usr/local/bin/packer:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=/usr/local/bin/:$PATH
export PATH=/usr/local/Cellar/mysql55/5.5.44/bin:$PATH
export PATH=/usr/local/Cellar/python/2.7.12_2/Frameworks/Python.framework/Versions/2.7/bin:$PATH

export AWS_CREDENTIAL_FILE=~/.aws_credentials
export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.34.0/libexec"

export EDITOR=vim
export CLICOLOR=1

export LEDGER_FILE=~/ledger-files/journal.ledger
export PASSWORD_STORE_DIR=~/.password-store

export JAVA_HOME="$(/usr/libexec/java_home)"

##############


alias vi="vim"

# Allow direnv to load .envrc files
eval "$(direnv hook zsh)"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Use a universal history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Load keychain (ssh-agent, gpg-agent)
eval $(keychain --quiet --inherit any --eval --agents ssh,gpg -Q id_rsa 4CEACD1C 1418F280)

source ~/.zplug/init.zsh
zplug 'landakram/lambda-mod-zsh-theme', as:theme
zplug 'zsh-users/zsh-autosuggestions'

zplug 'zsh-users/zsh-history-substring-search'

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

zplug 'zsh-users/zaw'

# Work around this issue:
# https://github.com/zsh-users/zsh-autosuggestions/issues/205
if [[ $ZSH_EVAL_CONTEXT == 'file' ]]; then
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2
fi
zplug load

bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search
zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select' max-lines 3
zstyle ':filter-select' case-insensitive yes # enable case-insensitive 
zstyle ':filter-select' extended-search yes # see below

