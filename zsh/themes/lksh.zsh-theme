# lksh.zsh-theme
#
# Author: Luke Shafer
# URL: http://lukeshafer.com/

# view colors with command `c256` in zsh

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
local git_bg="24"

# if iTerm renders the   characters at double width
# uncheck Settings > Profile > Text > Text Rendering > Use built-in Powerline glyphs
#
# Some Powerline glyphs for copying
#               
local left_sep=""
local right_sep=""

function ssh_prompt_info() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%F{250}@%F{$accent}%B$HOST%b"
  fi
}

function pwd_prompt() {
  echo "%F{$dark}%K{$main} %B%~%b%k%F{$main}$right_sep"
}

function user_prompt() {
  echo "%F{$accent}%n%f"
}

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green} %F{195}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%F{default}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{default}"
function git_prompt() {
  if [[ -n $(git_prompt_info) ]]; then
    echo " %F{$git_bg}$left_sep%K{$git_bg}$(git_prompt_info)%K{default}%F{$git_bg}$right_sep"
  else 
    echo ""
  fi

}

PROMPT="
\$(pwd_prompt) \$(git_prompt)%{$reset_color%}
%k\$(user_prompt)\$(ssh_prompt_info) %F{$light}%(!.#.»)%F{default}%K{default} "

RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) %F{$light}%t"

#
# Powerline Symbols
# Hard separators:  
# Soft separators:  
# Round separators:  
# Hard bottom angle separators:  
# Hard top angle separators:  
# Thin angle separators:    
# Flame separators:   
# Thin flame separators:   
# Pixelated separators:        
#
# Other useful chars:   »

