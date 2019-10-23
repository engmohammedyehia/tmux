#!/usr/bin/env bash

source $HOME/.tmux/plugins/helper.sh

main() {
  local battery=$(pmset -g batt | grep -E "InternalBattery" | grep -Eo "[0-9]+%")
  local batteryInt=$(pmset -g batt | grep -E "InternalBattery" | grep -Eo "[0-9]+%" | grep -Eo "[0-9]+")
  local battery_icon=$'\UF240 '
  local batteryIcon=$(_decode_unicode_escapes "${battery_icon-''}")
  local batteryChargingStatus=$(pmset -g batt | grep -E "InternalBattery" | grep -Eo "; charging")
  local batteryDisChargingStatus=$(pmset -g batt | grep -E "InternalBattery" | grep -E "discharging")
  local batteryStatusChargingColor="#009900"
  local batteryStatusDeadColor="#990000"
  local batteryStatusToShowColor="#8e8e8e"
  if [ "$batteryChargingStatus" ]; then
    batteryStatusToShowColor="$batteryStatusChargingColor"
  elif [ $batteryInt -lt 10 ]; then
    batteryStatusToShowColor="$batteryStatusDeadColor"
  else 
    batteryStatusToShowColor="#8e8e8e"
  fi
  printf "#[fg=#212121,bg=#121212]#[fg=$batteryStatusToShowColor,bg=#212121] $batteryIcon #[fg=#8e8e8e,bg=#212121]$battery%"
}

main