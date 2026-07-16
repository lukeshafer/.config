## History wrapper
function history() {
  local clear REPLY
  zparseopts -E -D c=clear

  if [[ -n "$clear" ]]; then
    print -nu2 "This will irreversibly delete your command history. Are you sure? [y/N] "
    builtin read -E
    [[ "$REPLY" = [yY] ]] || return 0

    print -nu2 >| "$HISTFILE"
    fc -p "$HISTFILE"
    print -u2 History file deleted.
  elif [[ $# -eq 0 ]]; then
    # show full history with timestamps (mm/dd/yyyy format)
    builtin fc -f -l 1
  else
    builtin fc -f -l "$@"
  fi
}

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
