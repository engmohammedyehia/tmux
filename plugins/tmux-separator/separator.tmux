#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

separator="#($CURRENT_DIR/separator.sh)"
plugin_placeholder="\#{separator_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$separator"
  updatePane "status-left" "$plugin_placeholder" "$separator"
}

main