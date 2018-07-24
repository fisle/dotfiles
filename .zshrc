export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"

plugins=(git extract)

source $ZSH/oh-my-zsh.sh

# User configuration
export TERMINAL=alacritty
export EDITOR=nvim
export GOPATH=$HOME/dev/gopath
export GOBIN=$GOPATH/bin
PATH="$PATH:$GOBIN"
PATH="$PATH:$HOME/scripts"
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.npm/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.bin"
export PATH=$PATH


setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

alias v='vagrant'
alias cat='bat'
alias ya='pacaur'
alias open='xdg-open'
alias vim='nvim'
alias gac='gco $(gba | sed "s/remotes\/origin\///g" | grep -Ev "(HEAD|\*)"  | sort | uniq | fzf)'
alias shh='ssh $(awk "/Host / { print \$2}" ~/.ssh/config | fzf)'
alias filu='vim $(fzf)'
alias cdc='cd $(find . -type d | fzf)'

function ggpf()
{
    git push origin "$(current_branch)" --force
}
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

function t()
{
    search=$(find ~/dev -maxdepth 2 -type d)
    result=$(echo $search | fzf)
    cd $result || return
    name=${PWD##*/}
    tmux split-window -h -p 37
    tmux rename-window $name
}

function p()
{
    search=$(find ~/dev -maxdepth 2 -type d)
    result=$(echo $search | fzf)
    cd $result || return
    name=${PWD##*/}
    tmux rename-window $name
}

function mm () {
    v ssh -c "m $@"
}
alias mmr='v ssh -c "mr"' 
alias gremove='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
