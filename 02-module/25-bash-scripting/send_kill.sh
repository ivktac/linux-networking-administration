#!/usr/bin/env bash

set -euo pipefail

total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MAX_RSS=${1:-$total_mem}

INTERVAL=10

echo "Watching for processes that exceed ${MAX_RSS} KB RSS..."
echo "Checking every ${INTERVAL} seconds. Press Ctrl+C to exit."

while true; do
    ps -eo pid=,rss= --no-headers | while read pid rss; do
        if [[ "$rss" -gt "$MAX_RSS" ]]; then
            echo "Process $pid exceeded ${MAX_RSS} KB RSS. Sending TERM signal..."
            kill -TERM $pid
        fi
    done
    sleep $INTERVAL
done
