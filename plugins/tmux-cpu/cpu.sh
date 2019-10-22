#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local cpu_icon=$'\uF080 '
  local cpuIcon=$(_decode_unicode_escapes "${cpu_icon-''}")
  local cpu=$(top -l 1 | grep -E "^CPU usage" | grep -Eo "[0-9]+\.[0-9]+" | head -1)
  printf "$cpuIcon $cpu"
}

main