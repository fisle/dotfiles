export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"

plugins=(git extract)

source $ZSH/oh-my-zsh.sh

# User configuration
export TERMINAL=alacritty
export EDITOR=vim
export GOPATH=$HOME/dev/gopath
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
PATH="$PATH:$GOBIN"
PATH="$PATH:$HOME/scripts"
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.npm/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$GOROOT/bin"
PATH="$PATH:$HOME/.emacs.d/bin"
export PATH=$PATH

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

alias v='vagrant'
alias cat='bat'
alias ya='pacaur'
alias open='xdg-open'
# alias vim='nvim'
alias gac='gco $(gba | sed "s/remotes\/origin\///g" | grep -Ev "(HEAD|\*)"  | sort | uniq | fzf)'
alias shh='ssh $(awk "/Host / { print \$2}" ~/.ssh/config | fzf)'
alias filu='vim $(fzf)'
alias cdc='cd $(find . -type d | fzf)'

function ggpf()
{
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" = "master" ]; then
        echo "Not gonna force push master branch"
    else
        git push origin "$(current_branch)" --force-with-lease
    fi
}
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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

dm () {
    container=$(docker-compose config --services | grep -E 'app|django|savmail' | grep -v 'db')
    manage_location=$(find . -type f -name manage.py)
    docker-compose exec "$container" python "$manage_location" "$@"
}

dmr () {
    config=$(docker-compose config)
    container=$(docker-compose config --services | grep -E 'app|django|savmail' | grep -v 'db')
    manage_location=$(find . -type f -name manage.py)
    composer_version=$(echo $config | awk '/version/ {print $2}')

    if [ "$composer_version" = "'3.7'" ]; then
        local_port=$(echo $config | awk '/published/ {print $3; exit}')
        target_port=$(echo $config | awk '/target/ {print $2; exit}')
    else
        local_port=$(echo $config | awk '/ports/ {getline; split($2,a,":"); print a[1]; exit}')
        target_port=$(echo $config | awk '/ports/ {getline; split($2,a,":"); split(a[2],b,"/"); print b[1]; exit}')
    fi
    docker-compose exec "$container" python "$manage_location" runserver 0.0.0.0:"$target_port"
}

alias d-c='docker-compose'

scrot () {
    date=$(date '+%Y-%m_%d-%H-%M-%S')
    filename="$HOME/Pictures/Screenshots/Screenshot-$date.png"
    maim "$@" "$filename" && echo "$filename" | xclip
}

export QT_STYLE_OVERRIDE=gtk2
alias kää='trans eng:fin'
alias pol='trans pol:eng'

export TERM="xterm-256color"

new_release () {
    git fetch --tags
    today=$(date '+%Y-%m-%d')
    revision=$(git tag --list | awk -F'.' '/'"$today"'/ {a=$2}END{print a+1}')
    release="rel/$today.$revision"
    timestamp=$(date +%Y-%m-%dT%H:%M%z)
    git tag -a "$release" -m "$timestamp"
    git push origin "$release"
    echo "Release $release done!"
}
gptag () {
    selected_tag=$(git tag --list | fzf)
    git push origin "$selected_tag"
}

# function df () {
#     command df "$@" | grep -v snap
# }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

gmd () {
    compare_against="$1"

    if [ -z "$compare_against" ]; then
        compare_against="master"
    fi

    git cherry -v "$compare_against" "$(git rev-parse --abbrev-ref HEAD)" | xclip
}

export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
eval $(keychain --eval --quiet id_rsa)

workon () {
    PROJECT="$1"

    if [ -z "$PROJECT" ]; then
        echo "No project specified."
        return 1
    fi

    source "$HOME/.venv/$PROJECT/bin/activate"
}
