# lksh.zsh-theme
#
# Author: Luke Shafer
# URL: http://lukeshafer.com/

# %F{black}\${(l.\$COLUMNS..-.)}%{$reset_color%}

# local colors=("blue" "cyan" "magenta" "green" "yellow" "red")
# local color_index="$(($RANDOM % ${#colors[@]} + 1))"

case "$HOST" in
  snerver)
    local main="29"
    local accent="36"
    ;;
  lukelaptop)
    local main="103"
    local accent="105"
    ;;
  gombertcrombert)
    local main="68"
    local accent="69"
    ;;
  K4L7X4FWFW)
    local main="174"
    local accent="204"
    ;;
  *)
    local main="203"
    local accent="205"
    ;;
esac

local dark="236"
local light="231"

# iTerm renders the   characters differently
# if [[ -n "$ITERM_PROFILE" ]] then
#   local left_sep=" "
#   local right_sep=" "
# else
  local left_sep=""
  local right_sep=""
# fi
#           
#    

function ssh_prompt_info() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%F{250}@%F{$accent}%B$HOST%b"
  fi
}

function pwd_prompt() {
  echo "%F{$dark}%K{$main} %B%~%b %k%F{$main}$left_sep"
}

function user_prompt() {
  echo "%F{$accent}%n%f"
}

PROMPT="
\$(pwd_prompt) \$(git_prompt_info)%{$reset_color%}
%k\$(user_prompt)\$(ssh_prompt_info) %F{$light}%(!.#.»)%F{default}%K{default} "

RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) %F{$light}%t"

# useful chars:  
#            »

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green} 󰊢 %F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%F{default}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %F{default}"

