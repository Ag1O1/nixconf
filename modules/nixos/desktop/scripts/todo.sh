#!/usr/bin/env bash
set -euo pipefail

DIR="$HOME/Documents/0.Personal/0.Journal/daily"
mkdir -p "$DIR"

today="$DIR/$(date +%F).md"
yesterday="$DIR/$(date -d 'yesterday' +%F).md"

if [[ -f "$today" ]]; then
  nvim "$today"
  exit 0
fi

extract_section() {
  local file="$1"
  local header="$2"
  local header2="$3"
  awk -v h="$header" -v h2="$header2" '$0 ~"^## (" h "|" h2 ")$" {flag=1;next}/^## /{flag=0} flag' "$file"
}

preserve=$(extract_section "$yesterday" "Preserve" "Weekly Notes")

final="# $(date +%F)

## TODO

- 

## Journal


## Preserve
$preserve"

echo "$final" >"$today"
