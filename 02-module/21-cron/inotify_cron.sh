#!/bin/bash

WATCH_DIRS=($(ls -d /etc/cron* /var/spool/cron))
LOG_FILE="/var/log/cronedits.log"
EXCLUDE_PATTERN="\.swp$|\.swpx$|4913$|~$"

inotifywait -m -r -e create,modify,delete,move --exclude "$EXCLUDE_PATTERN" \
  --format "%T %w%f %e" --timefmt "%Y-%m-%d %H:%M:%S" "${WATCH_DIRS[@]}" --output $LOG_FILE
