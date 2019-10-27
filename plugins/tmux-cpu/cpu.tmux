#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

cpu="#($CURRENT_DIR/cpu.sh)"
plugin_placeholder="\#{cpu_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$cpu"
  updatePane "status-left" "$plugin_placeholder" "$cpu"
}

main