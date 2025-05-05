alias cl=clear
alias l="ls -lrf"
alias ll="ls -alrh"
alias gs="git status"
alias adog="git adog"
alias vim="nvim"
alias python="python3"
alias pip="pip3"

autoload -U colors && colors
setopt prompt_subst

git_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "(${ref#refs/heads/})"
}

get_env_label() {
  if [[ -n "$TMUX" ]]; then
    tmux display-message -p '#S'
  else
    echo "Mac"
  fi
}

PROMPT='%{$fg[blue]%}%n@$(get_env_label)%{$reset_color%} %{$fg[cyan]%}%1~%{$reset_color%} %{$fg[green]%}$(git_info)%{$reset_color%} %# '
