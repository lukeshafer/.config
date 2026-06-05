# zmodload zsh/zprof # uncomment to profile performance

export ZSH="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

ZSH_THEME="lksh"

# run lib startup
source $ZSH/init-lib.zsh

source $ZSH/hostnames.zsh
resolve_ssh_client_host
export PC_CONTEXT=$(idhost)
export KEYTIMEOUT=1

# Common config
export EDITOR="nvim" # Preferred editor for local and remote sessions
export MANPAGER='nvim +Man!'
export LESS="RrX"

export PATH="$HOME/.local/bin:$PATH"

# Common aliases
alias zreload="source ~/.zshrc"
alias zrc="nvim $ZSH && source ~/.zshrc"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gf="git fetch"
alias gpl="git pull"
alias gs="git status"
alias gd="git diff"
alias grs="git restore --staged"
alias gacp="git add . && git commit -m $1 && git push"
alias gsh='git stash'
alias gsha='git stash apply'
alias gm='git merge'
alias gch='git checkout'
#   
local GIT_TREE_REGEX='s/\*//'
alias git-tree='git log --oneline --graph --color --all --decorate'
alias gtree='git-tree'
# alias git-tree='git log --oneline --graph --color --all --decorate | sed -E $GIT_TREE_REGEX | less'

# alias tmr='tmux source ~/.config/tmux/tmux.conf'
# alias tmc="nvim ~/.config/tmux/tmux.conf && tmr"

# make dir and cd into it
function mkcd() {
	mkdir -p "$1" && cd "$1"
}

alias c256='for i in {0..255}; do printf "\e[48;5;%sm %3s \e[0m" $i $i; [ $((($i+1)%16)) -eq 0 ] && echo; done'

export DISABLE_TELEMETRY=1
export DO_NOT_TRACK=1

source $ZSH/config-$PC_CONTEXT.zsh

# zprof # uncomment to profile
