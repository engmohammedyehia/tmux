#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

current_time="#($CURRENT_DIR/time.sh)"
plugin_placeholder="\#{current_time_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$current_time"
  updatePane "status-left" "$plugin_placeholder" "$current_time"
}

main