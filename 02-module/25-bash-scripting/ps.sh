#!/usr/bin/env bash

set -euo pipefail

while true; do
    {
        date
        ps aux
    } >> /var/log/ps.log
    sleep 1
done
