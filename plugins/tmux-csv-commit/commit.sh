#!/usr/bin/env bash

PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}" -t0)
cd $PANE_PATH

if command -v perl > /dev/null 2>&1; then
  _decode_unicode_escapes() {
    printf '%s' "$*" | perl -CS -pe 's/(\\u([0-9A-Fa-f]{1,4})|\\U([0-9A-Fa-f]{1,8}))/chr(hex($2.$3))/eg' 2>/dev/null
  }
elif bash --norc --noprofile -c '[[ ! $BASH_VERSION < 4.2. ]]' > /dev/null 2>&1; then
  _decode_unicode_escapes() {
    bash --norc --noprofile -c "printf '%b' '$*'"
  }
elif command -v python > /dev/null 2>&1; then
  _decode_unicode_escapes() {
    python -c "import re; import sys; sys.stdout.write(re.sub(r'\\\U([0-9A-Fa-f]{1,8})', lambda match: r'\U%s' % match.group(1).zfill(8), r'$*').encode().decode('unicode-escape', 'ignore'))"
  }
else
  _decode_unicode_escapes() {
    printf '%b' "$*"
  }
fi

git_status() {
  
  local commit_name=$(git rev-parse --short=8 HEAD)
  local commit_icon=$'\uE729'
  local commitIcon=$(_decode_unicode_escapes "${commit_icon-''}")
  local lock_icon=$'\UF023'
  local lockIcon=$(_decode_unicode_escapes "${lock_icon-''}")

  local branch_has_changes=$(git diff-index --name-only HEAD --)
  local change_color='colour252'
  local label_color='#000000'
  
  if [ -n "$branch_has_changes" ]; then 
    change_color='#ffc107'
    label_color='#000000'
  fi

  if [[ -n $commit_name ]]; then
    printf "#[fg=$change_color,bg=#121212,nobold]#[fg=$label_color,bg=$change_color,nobold] $commitIcon $commit_name #[fg=#0f5f86,bg=$change_color,nobold]#[fg=#ffffff,bg=#0f5f86,nobold] $(whoami) $lockIcon "
  else 
    printf "#[fg=colour252,bg=#121212,nobold]#[fg=colour233,bg=colour252,nobold] $(whoami) $lockIcon "
  fi
}

main() {
  git_status
}

main