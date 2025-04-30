#!/usr/bin/env bash

set -euo pipefail

IFS=$'\n\t'

LOG_FILE="PS.log"
PREFIX="PS.log"
SUFFIX=".gz"
MAX_COMPRESSIONS=5
INTERVAL=10
NUM_ROTATIONS=5

log_processes() {
    {
        echo "Processes at $(date):"
        ps aux
        echo "---"
    } >> "$LOG_FILE"
}

rotate_logs() {
    [[ -f "$LOG_FILE" ]] || return 0

    gzip -f "$LOG_FILE" || return 0

    [[ -f "${LOG_FILE}${SUFFIX}" ]] || return 0

    for ((i=MAX_COMPRESSIONS; i>=2; i--)); do
        local prev=$((i - 1))
        local prev_file="$PREFIX$prev$SUFFIX"
        local curr_file="$PREFIX$i$SUFFIX"

        if [[ -f "$prev_file" ]]; then
            mv "$prev_file" "$curr_file" 2>/dev/null || true
        fi
    done

    mv "$LOG_FILE$SUFFIX" "${PREFIX}1${SUFFIX}" 2>/dev/null || true

    local oldest_file="${PREFIX}$((MAX_COMPRESSIONS+1))${SUFFIX}"
    if [[ -f "$oldest_file" ]]; then
        rm "$oldest_file" 2>/dev/null
    fi
}

count=0
while true; do
    log_processes

    count=$((count+1))

    if ((count >= NUM_ROTATIONS)); then
        rotate_logs
        count=0
    fi

    sleep "$INTERVAL"
done
