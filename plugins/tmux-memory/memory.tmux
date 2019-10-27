#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

memory="#($CURRENT_DIR/memory.sh)"
plugin_placeholder="\#{memory_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$memory"
  updatePane "status-left" "$plugin_placeholder" "$memory"
}

main