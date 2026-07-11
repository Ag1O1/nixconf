#!/usr/bin/env bash
# todo.sh — creates today's todo file, carrying over the #Weekly: section
# from yesterday's file (if it exists and today's doesn't yet).
set -euo pipefail

TODO_DIR="$HOME/Documents/0.Personal/0.Journal/daily"
mkdir -p "$TODO_DIR"

today="$TODO_DIR/$(date +%F).md"
yesterday="$TODO_DIR/$(date -d 'yesterday' +%F).md"

# If today's file already exists, do nothing — this is the
# "don't add if it's already there" guard.
if [[ -f "$today" ]]; then
  echo "Already exists: $today"
  exit 0
fi

# Pull everything under "#Weekly:" up to (but not including) the next
# "#" heading in yesterday's file.
extract_section() {
  local file="$1" heading="$2"
  awk -v h="$heading" '
        $0 ~ "^#"h":?[[:space:]]*$" { grab=1; next }
        /^#/ && grab { exit }
        grab { print }
    ' "$file"
}

weekly=""
if [[ -f "$yesterday" ]]; then
  weekly="$(extract_section "$yesterday" "Weekly")"
  # strip leading/trailing blank lines
  weekly="$(echo "$weekly" | sed -e '/./,$!d' -e ':a' -e '/^\n*$/{$d;N;ba' -e '}')"
fi

{
  echo "#TODO:"
  echo
  echo "* "
  echo
  echo "#Weekly:"
  echo
  if [[ -n "$weekly" ]]; then
    echo "$weekly"
  else
    echo "* "
  fi
  echo
  echo "#Journal:"
  echo
  echo "* "
  echo
} >"$today"

echo "Created $today"
