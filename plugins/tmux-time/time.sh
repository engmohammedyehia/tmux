#!/usr/bin/env bash

PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}" -t0)
cd $PANE_PATH

source $HOME/.tmux/plugins/helper.sh

main() {
  local time=$(date | grep -oE "\d{2}:\d{2}")
  local time_icon=$'\uF017 '
  local timeIcon=$(_decode_unicode_escapes "${time_icon-''}")
  printf "$timeIcon${time:0:5} "
}

main