# af-magic.zsh-theme (modified by luke)
#
# Author: Andy Fleming
# URL: http://andyfleming.com/

# command to view colors: spectrum_ls

# dashed separator size
# function dashes {
#   # check either virtualenv or condaenv variables
#   local python_env_dir="${VIRTUAL_ENV:-$CONDA_DEFAULT_ENV}"
#   local python_env="${python_env_dir##*/}"
#   local git_branch_length="$(git branch --show-current | awk '{print length($0)}')"
#   local git_branch_dirty=""
#
#   local base_columns="$(( COLUMNS - ${#PWD} + ${#HOME} - 1 ))"
#
#   # if there is a python virtual environment and it is displayed in
#   # the prompt, account for it when returning the number of dashes
#   if [[ -n "$python_env" && "$PS1" = *\(${python_env}\)* ]]; then
#     echo $(( base_columns - ${#python_env} - 3 ))
#   else
#     echo $base_columns
#   fi
# }

# primary prompt: dashed separator, directory and vcs info
# PS1="%F{blue}%~%F{black}\${(l.\$(dashes)..-.)}%{$reset_color%}
PROMPT="%F{black}\${(l.\$COLUMNS..-.)}%{$reset_color%}
%F{blue}%~\$(git_prompt_info)%{$reset_color%}%E
%F{magenta}%(!.#.»)%{$reset_color%} "
# PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%}) %F{black}%n%{$reset_color%} %F{magenta}%t%{$reset_color%}

hi"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue} (%F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%{$reset_color%}"

