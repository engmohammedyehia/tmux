#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local home_icon=$'\ue711'
  local homeIcon=$(_decode_unicode_escapes "${home_icon-''}")
  printf "#[fg=colour232,bg=colour252,nobold] $homeIcon #S"
}

main
