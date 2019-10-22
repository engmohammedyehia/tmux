#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local ram_icon=$'\uf463'
  local ramIcon=$(_decode_unicode_escapes "${ram_icon-''}")
  local ramUnit="GB"
  local ram=$(top -l 1 | grep -E "^Phys" | grep -Eo "[0-9]+" | head -1)
  printf "$ramIcon $ram$ramUnit"
}

main
