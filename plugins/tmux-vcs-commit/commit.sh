#!/usr/bin/env bash

PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}" -t0)
cd $PANE_PATH

source $HOME/.tmux/plugins/helper.sh

git_status() {
  
  local commit_name=$(git rev-parse --short=8 HEAD)
  local commit_icon=$'\uE729'
  local commitIcon=$(_decode_unicode_escapes "${commit_icon-''}")
  local lock_icon=$'\Uf83d'
  local lockIcon=$(_decode_unicode_escapes "${lock_icon-''}")

  local branch_has_changes=$(git diff-index --name-only HEAD --)
  local change_color='colour252'
  local label_color='#000000'
  
  if [ -n "$branch_has_changes" ]; then 
    change_color='#ffc107'
    label_color='#000000'
  fi

  if [[ -n $commit_name ]]; then
    printf "#[fg=$change_color,bg=#121212,nobold]#[fg=$label_color,bg=$change_color,nobold] $commitIcon $commit_name #[fg=#00a2fa,bg=$change_color,nobold]#[fg=#000000,bg=#00a2fa,nobold] $(whoami) $lockIcon "
  else 
    printf "#[fg=colour252,bg=#121212,nobold]#[fg=colour233,bg=colour252,nobold] $(whoami) $lockIcon "
  fi
}

main() {
  git_status
}

main
