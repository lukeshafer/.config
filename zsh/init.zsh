# zmodload zsh/zprof # uncomment to profile performance

export ZSH="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

ZSH_THEME="lksh"

# --- Resolve context ---
source $ZSH/hostnames.zsh
export PC_CONTEXT=$(idhost)

# --- Completion fpath ---
fpath=($ZSH/completions/$PC_CONTEXT(N) $ZSH/completions/shared(N) $ZSH/completions $fpath)

mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)$ZSH_CACHE_DIR/completions]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# --- Initialize completion system ---
autoload -U compinit zrecompile

ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
compinit -d "$ZSH_COMPDUMP"

# Bytecode-compile the compdump for faster loading.
# Saves a few ms on startup for large compdumps. Uncomment if startup feels slow.
# if command mkdir "${ZSH_COMPDUMP}.lock" 2>/dev/null; then
#   zrecompile -q -p "$ZSH_COMPDUMP"
#   command rm -rf "$ZSH_COMPDUMP.zwc.old" "${ZSH_COMPDUMP}.lock"
# fi

# --- Load lib files ---
for lib_file ("$ZSH"/lib/*.zsh); do
  source "$lib_file"
done
unset lib_file

# --- Load theme ---
autoload -U colors && colors
setopt prompt_subst

if [[ -n "$ZSH_THEME" ]]; then
  source "$ZSH/themes/$ZSH_THEME.zsh-theme"
fi

# Completion colors (must come after theme loads LS_COLORS)
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- Environment ---
resolve_ssh_client_host
export KEYTIMEOUT=1
export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export LESS="RrX"
export PATH="$HOME/.local/bin:$PATH"
export DISABLE_TELEMETRY=1
export DO_NOT_TRACK=1
export GLAMOUR_STYLE="dark"

# --- Shared aliases and context config ---
source $ZSH/aliases.zsh
source $ZSH/config-$PC_CONTEXT.zsh

# zprof # uncomment to profile
