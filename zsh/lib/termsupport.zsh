# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen, iterm, and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  setopt localoptions nopromptsubst

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*|wezterm*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
      if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        print -Pn "\e]2;${2:q}\a" # set window name
        print -Pn "\e]1;${1:q}\a" # set tab name
      else
        # Try to use terminfo to set the title if the feature is available
        if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} )); then
          print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
        fi
      fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"
# Avoid duplication of directory in terminals with independent dir display
if [[ "$TERM_PROGRAM" == Apple_Terminal ]]; then
  ZSH_THEME_TERM_TITLE_IDLE="%n@%m"
fi

# Runs before showing the prompt
function _termsupport_precmd {
  title "$ZSH_THEME_TERM_TAB_TITLE_IDLE" "$ZSH_THEME_TERM_TITLE_IDLE"
}

# Runs before executing the command
function _termsupport_preexec {
  emulate -L zsh
  setopt extended_glob

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    local job_id jobspec="${cmdargs[2]#%}"
    case "$jobspec" in
      <->) job_id=${jobspec} ;;
      ""|%|+) job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}"
  local LINE="${2:gs/%/%%}"

  title "$CMD" "%100>...>${LINE}%<<"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _termsupport_precmd
add-zsh-hook preexec _termsupport_preexec

# --- OSC 7: Report working directory to terminal emulator ---
# Enables "open new tab in same directory" and clickable paths.
# Skipped in SSH sessions (terminal can't access remote paths).

if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
  return
fi

case "$TERM" in
  xterm*|putty*|rxvt*|konsole*|mlterm*|alacritty*|screen*|tmux*) ;;
  contour*|foot*) ;;
  *)
    case "$TERM_PROGRAM" in
      Apple_Terminal|iTerm.app) ;;
      *) return ;;
    esac ;;
esac

function _termsupport_cwd {
  setopt localoptions unset
  local URL_HOST URL_PATH
  URL_HOST="$(urlencode $HOST)" || return 1
  URL_PATH="$(urlencode $PWD)" || return 1

  # Konsole errors if the HOST is provided
  [[ -z "$KONSOLE_PROFILE_NAME" && -z "$KONSOLE_DBUS_SESSION" ]] || URL_HOST=""

  printf "\e]7;file://%s%s\e\\" "${URL_HOST}" "${URL_PATH}"
}

add-zsh-hook precmd _termsupport_cwd
