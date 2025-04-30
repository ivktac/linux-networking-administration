#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

usage() {
    echo "Usage: ${0##*/} [DIRECTORY] [--mac]"
    exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
fi

dir="$1"

if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist." >&2
    exit 2
fi

mode="ip"
regex='((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'

if [[ "${2:-}" == "--mac" ]]; then
    mode="mac"
    regex='([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}'
fi

log_file="${mode^^}.log"

: > "$log_file"

while IFS= read -r -d '' file; do
    grep -oE "$regex" "$file" 2>/dev/null | sed "s|^|$file: |" >> "$log_file" || true
done < <(find "$dir" -type f -not -name "$log_file" -print0)

cat "$log_file"
