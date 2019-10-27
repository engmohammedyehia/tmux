#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

branch="#($CURRENT_DIR/branch.sh)"
plugin_placeholder="\#{branch_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$branch"
  updatePane "status-left" "$plugin_placeholder" "$branch"
}

main