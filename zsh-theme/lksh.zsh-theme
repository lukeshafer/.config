# af-magic.zsh-theme (modified by luke)
#
# Author: Andy Fleming
# URL: http://andyfleming.com/

# command to view colors: spectrum_ls

# dashed separator size
function afmagic_dashes {
  # check either virtualenv or condaenv variables
  local python_env_dir="${VIRTUAL_ENV:-$CONDA_DEFAULT_ENV}"
  local python_env="${python_env_dir##*/}"

  # if there is a python virtual environment and it is displayed in
  # the prompt, account for it when returning the number of dashes
  if [[ -n "$python_env" && "$PS1" = *\(${python_env}\)* ]]; then
    echo $(( COLUMNS - ${#python_env} - 3 ))
  else
    echo $COLUMNS
  fi
}

# primary prompt: dashed separator, directory and vcs info
PS1="%F{black}\${(l.\$(afmagic_dashes)..-.)}%{$reset_color%}
%F{blue}%~\$(git_prompt_info)\$(hg_prompt_info) %F{magenta}%(!.#.»)%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=" %F{black}%n%{$reset_color%}"
RPS1+=" %F{magenta}%t%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{blue}(%F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" %F{blue}(%F{cyan}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="%F{yellow}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%F{blue})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" %F{blue}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
