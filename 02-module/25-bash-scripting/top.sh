#!/bin/bash

while true; do
    clear

    uptime

    total=$(ps -ef --no-headers | wc -l)
    running=$(ps -eo stat --no-headers | grep -c '^R')
    sleeping=$(ps -eo stat --no-headers | grep -c '^S')
    dsleep=$(ps -eo stat --no-headers | grep -c '^D')
    stopped=$(ps -eo stat --no-headers | grep -c '^[Tt]')
    zombie=$(ps -eo stat --no-headers | grep -c '^Z')

    echo "Tasks: ${total} total, ${running} running, ${sleeping} sleep, ${dsleep} d-sleep, ${stopped} stopped, ${zombie} zombie"

    mpstat | awk '/all/ { printf "%%Cpu(s): %.1f us, %.1f sy, %.1f ni, %.1f id, %.1f wa, %.1f hi, %.1f si, %.1f st\n", $3, $5, $4, $12, $6, $7, $8, $9 }'
    free -m | awk 'NR == 2 { printf "MiB Mem: %.1f total, %.1f free, %.1f used, %.1f buff/cache\n", $2, $4, $3, $6 }'
    free -m | awk '/^Mem:/ { available_mem = $NF } /^Swap:/ { printf "MiB Swap: %.1f total, %.1f free, %.1f used, %.1f avail Mem\n ", $2, $3, $4, available_mem } '

    echo ""

    read -n 1 -t 0.1 -r key_press

    ps -eo pid,user,pri,nice,size,rssize,state,pcpu,pmem,time,comm --sort="${sort_param:-pid}" | column -t | head -n 11

    if [[ -n "$key_press" ]]; then
        case "$key_press" in
            [Pp]) sort_param="-%cpu"; continue;;
            [Mm]) sort_param="-%mem"; continue ;;
            [Nn]) sort_param="pid"; continue ;;
            [Qq]) echo ""; exit ;;
            *) ;;
        esac
    fi

    sleep 1
done
