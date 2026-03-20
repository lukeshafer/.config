# lksh.zsh-theme
#
# Author: Luke Shafer
# URL: http://lukeshafer.com/

# %F{black}\${(l.\$COLUMNS..-.)}%{$reset_color%}

local colors=("blue" "cyan" "magenta" "white" "green" "yellow" "red")
local color_index="$(($(echo $TMUX_PANE | tr -d -c 0-9) % ${#colors[@]} + 1))"
local main="$colors[$color_index]"
local accent="white"

PROMPT="
%F{$accent}%K{black}%t%F{$main} %F{black}%K{$main}%B%~%b%K{default}%F{$main}\$(git_prompt_info)%{$reset_color%}
%F{$main}%n%F{default}%K{default} %F{$accent}%(!.#.»)%F{default}%K{default} "

RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) "

# useful chars:  
#            »

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green} 󰊢 %F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%F{default}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %F{default}"

