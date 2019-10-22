#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local home_icon=$'\uF015'
  local homeIcon=$(_decode_unicode_escapes "${home_icon-''}")
  printf "#[fg=colour232,bg=colour252,bold] $homeIcon #S"
}

main