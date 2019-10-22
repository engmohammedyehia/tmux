#!/usr/bin/env bash

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

main() {
  local battery_icon=$'\UF240 '
  local batteryIcon=$(_decode_unicode_escapes "${battery_icon-''}")
  printf "$batteryIcon"
}

main