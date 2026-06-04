# lksh.zsh-theme
#
# Author: Luke Shafer
# URL: http://lukeshafer.com/

# %F{black}\${(l.\$COLUMNS..-.)}%{$reset_color%}

local colors=("blue" "cyan" "magenta" "green" "yellow" "red")
local color_index="$(($RANDOM % ${#colors[@]} + 1))"
local main="magenta"
local accent="116"

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

# function zle-line-init zle-keymap-select {
#   VI_MODE="${${KEYMAP/vicmd/ }/(main|viins)/ }"
#   if [[ $KEYMAP == vicmd ]]; then
#     printf '\e[2 q'  # block cursor
#   else
#     printf '\e[6 q'  # beam cursor
#   fi
#   zle reset-prompt
# }
#
# zle -N zle-line-init
# zle -N zle-keymap-select

function ssh_prompt_info() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%F{34}%K{default} %B󱘖 $HOST %F{$main}$right_sep%b"
  fi
}

function pwd_prompt() {
  echo "%F{black}%K{$main} %~ "
}

PROMPT="
\$(ssh_prompt_info)\$(pwd_prompt)%K{default}%F{$main}$left_sep%K{default} \$(git_prompt_info)%{$reset_color%}
%F{$main}%n%F{default}%K{default} %F{white}%(!.#.»)%F{default}%K{default} "

RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) %F{white}%t"

# useful chars:  
#            »

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green} 󰊢 %F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%F{default}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %F{default}"

