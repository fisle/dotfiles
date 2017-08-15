export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"

plugins=(git extract)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=nvim
export GOPATH=$HOME/dev/gopath
export GOBIN=$GOPATH/bin
PATH="$PATH:$GOBIN"
PATH="$PATH:$HOME/scripts"
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.npm/bin"
export PATH=$PATH

alias v='vagrant'
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
