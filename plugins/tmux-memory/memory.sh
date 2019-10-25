#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local ram_icon=$'\uf463'
  local ramIcon=$(_decode_unicode_escapes "${ram_icon-''}")
  local ramUnit="GB"
  local ram=$(top -l 1 | grep -E "^Phys" | grep -Eo "[0-9]+" | head -1)
  local cachedFiles=$(top -l 1 | grep -E "^Phys" | grep -Eo "[0-9]+" | tail -1)
  if [ "$ram" -gt "1000" ]; then
    ram=$((ram/1024))
  fi
  if [ "$cachedFiles" -gt "1000" ]; then
    cachedFiles=$((cachedFiles/1024))
  fi
  printf "$ramIcon $(echo `expr $ram - $cachedFiles`)$ramUnit"
}

main
