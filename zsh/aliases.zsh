# --- Shell ---
alias zreload="source ~/.zshrc"
alias zrc="nvim $ZSH && source ~/.zshrc"

# --- Navigation ---
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# --- Listing ---
# LS colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"  # BSD ls (macOS)
if [[ -z "$LS_COLORS" ]]; then             # GNU ls (Linux)
  if (( $+commands[dircolors] )); then
    [[ -f "$HOME/.dircolors" ]] \
      && source <(dircolors -b "$HOME/.dircolors") \
      || source <(dircolors -b)
  else
    export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi

case "$OSTYPE" in
  (darwin|freebsd)*) alias ls='ls -G' ;;
  *) command ls --color /dev/null &>/dev/null && alias ls='ls --color=tty' ;;
esac

alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Colored diff
if command diff --color /dev/null{,} &>/dev/null; then
  function diff() { command diff --color "$@"; }
fi

# --- Git ---
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
alias git-tree='git log --oneline --graph --color --all --decorate'
alias gtree='git-tree'

# --- Grep ---
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}"
alias egrep="grep -E"
alias fgrep="grep -F"

# --- Clipboard / JSON ---
alias jsonf='clippaste | node -e "console.log(JSON.stringify(JSON.parse(require(\"fs\").readFileSync(\"/dev/stdin\",\"utf8\")), null, 2))"'
alias jsons='clippaste | node -e "console.log(JSON.stringify(JSON.parse(require(\"fs\").readFileSync(\"/dev/stdin\",\"utf8\"))))"'

# --- Misc ---
alias c256='for i in {0..255}; do printf "\e[48;5;%sm %3s \e[0m" $i $i; [ $((($i+1)%16)) -eq 0 ] && echo; done'
