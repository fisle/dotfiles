# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="clean"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git extract)

source $ZSH/oh-my-zsh.sh
export EDITOR=vim
# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
export PATH=$PATH:$HOME/scripts
export PATH="$PATH:$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
export PATH="$PATH:$HOME/dev/gopath/bin"
export PANEL_FIFO="/tmp/panel-fifo"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
alias mpd='mpd ~/.config/mpd/mpd.conf'
export TMPDIR=/tmp

alias kää='google-translate en fi'
alias v='vagrant'
export GOPATH=~/dev/gopath
alias fimutt='mutt -F ~/.mutt-fisle'
alias gnw='/usr/share/git/workdir/git-new-workdir'
alias open='xdg-open'
alias vim='nvim'
alias ya='yaourt'
