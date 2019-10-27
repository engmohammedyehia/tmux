#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local separator_icon=$'\ufc5e'
  local separatorIcon=$(_decode_unicode_escapes "${separator_icon-''}")
  printf " $separatorIcon "
}

main