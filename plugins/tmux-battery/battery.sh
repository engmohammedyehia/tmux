#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local battery=$(pmset -g batt | grep -E "InternalBattery" | grep -Eo "[0-9]+%")
  local battery_icon=$'\UF240 '
  local batteryIcon=$(_decode_unicode_escapes "${battery_icon-''}")
  printf "#[fg=#212121,bg=#121212]#[fg=#8e8e8e,bg=#212121] $batteryIcon $battery%"
}

main