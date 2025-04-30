#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage: ${0##*/} [directory]"
    exit 1
}

if [[ $# -gt 1 ]]; then
    usage
fi

dir="${1:-$(pwd)}"

if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist." >&2
    exit 1
fi

find "$dir" -type f -exec basename {} \; |
    awk -F. '{ if ($0 !~ /^\./ && NF > 1) printf ".%s\n", $NF }' | sort | uniq -c | sort -k2 |
    awk '{printf "%s - %d\n", $2, $1}'