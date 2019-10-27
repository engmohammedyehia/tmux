#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

battery="#($CURRENT_DIR/battery.sh)"
plugin_placeholder="\#{battery_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$battery"
  updatePane "status-left" "$plugin_placeholder" "$battery"
}

main