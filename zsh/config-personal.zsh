# --- Environment ---
export N_PREFIX="$HOME/.local"
export AUR_PAGER="nvim"

# --- PATH ---
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

export BUN_INSTALL="/home/luke/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export DENO_INSTALL="/home/luke/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PNPM_HOME="/home/luke/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/home/luke/.path"

# --- Manpath ---
unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# --- SSH ---
alias snerv="ssh snerver"

# --- Caddy ---
alias caddyconfig='sudoedit /etc/caddy/Caddyfile'
alias caddyrestart='sudo systemctl restart caddy'
alias caddyreload='caddy reload --config /etc/caddy/Caddyfile'
alias ced='caddyconfig && caddyreload'
alias cadhtml='nvim /etc/caddy/index.html'
alias cadcss='nvim /etc/caddy/style.css'
alias cadlog='sudo systemctl status caddy'

# --- DNS ---
alias dnsedit='sudoedit /etc/hosts'
alias dnsrestart='sudo systemctl restart dnsmasq'
alias dns='dnsedit && dnsrestart'

# --- Docker ---
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'

# --- Config editing ---
alias brc='nvim ~/.bashrc && zreload'
alias bls='nvim ~/.bash_aliases && zreload'
alias lsbls='cat ~/.bash_aliases'
alias nvrc='nvim ~/.config/nvim/'
alias sshedit='nvim ~/.ssh/authorized_keys'
alias tmr="tmux source-file ~/.config/tmux/tmux.conf"
alias tmc="nvim ~/.config/tmux/tmux.conf && tmr"

# --- Navigation ---
alias data='cd /mnt/data'
alias open="open_command"

# --- Networking ---
alias ports='sudo lsof -i -P -n | grep LISTEN'

function cprt() {
  sudo lsof -i -P -n | grep ":$1" | grep LISTEN
}

# --- Utilities ---
function unzilp() {
  ARG_NAME=$(echo $1 | cut -d '.' -f 1)
  unzip -q $1 -d ./$ARG_NAME
  rm $1
  CUR_DIR=$(pwd)
  echo "unzipped ./$1 to $CUR_DIR/$ARG_NAME/"
}

# --- Git ---
alias ghnew="gh repo create --source=. --remote=origin --public && git push --set-upstream origin main"
alias gm-devtoqa="gch qa && gm dev && gp && gch dev"

# --- Fuzzy find ---
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function fp() {
  local dir
  dir=$(find repos bots -type d -name '.git' | sed -r 's|/[^/]+$||' | sort -u \
                   | fzf +m) &&
  clear &&
  cd "$dir"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- AI ---
function aia() { opencode run "$*"; }

# --- Bun completions ---
[ -s "/home/luke/.bun/_bun" ] && source "/home/luke/.bun/_bun"

# --- Package Management ---
alias sync-packages="sudo pacman -S --needed - < ~/.config/packages/pacman-packages.txt"
