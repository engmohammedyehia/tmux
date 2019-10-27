#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

home="#($CURRENT_DIR/home.sh)"
plugin_placeholder="\#{home_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$home"
  updatePane "status-left" "$plugin_placeholder" "$home"
}

main