#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/../helper.sh

commit="#($CURRENT_DIR/commit.sh)"
plugin_placeholder="\#{commit_plugin}"

main() {
  updatePane "status-right" "$plugin_placeholder" "$commit"
  updatePane "status-left" "$plugin_placeholder" "$commit"
}

main