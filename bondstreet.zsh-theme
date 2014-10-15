function getHour() {

  local hour=$(date +"%H");
  local time="%T";
  local color=%{$fg[green]%};
  local default_limit="16";

  if [ -z "$WORK_HOUR_LIMIT" ]; then
    WORK_HOUR_LIMIT=$default_limit;
  fi

  if [[ "$hour" > "$WORK_HOUR_LIMIT" ]]; then
    color=%{$fg[red]%};
  fi

  echo $color$time;
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='%{$fg_bold[green]%}%p%{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}
${ret_status}%{$reset_color%}'

RPROMPT='$(getHour)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
