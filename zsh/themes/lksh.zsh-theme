# lksh.zsh-theme
#
# Author: Luke Shafer
# URL: http://lukeshafer.com/

# %F{black}\${(l.\$COLUMNS..-.)}%{$reset_color%}
PROMPT="
%K{blue}%F{black} %B%~/%b %K{default}%F{blue}\$(git_prompt_info)%{$reset_color%}
%F{magenta}%t%{$reset_color%} %F{magenta}%(!.#.»)%F{default}%K{default} "

# right prompt: return code, virtualenv and context (user@host)
RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) %F{black}%n%{$reset_color%} %F{magenta}%t%{$reset_color%}"

# useful chars:  
# 

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green} 󰊢 %F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%F{default}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %F{default}"

