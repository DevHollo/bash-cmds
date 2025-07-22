#!/bin/bash

show_seconds=false
no_text=false

for arg in "$@"; do
    case "$arg" in
        -s|--seconds)
            show_seconds=true
            ;;
        -nt|--no-text)
            no_text=true
            ;;
    esac
done

if $show_seconds; then
    boot_time=$(date -d "$(uptime -s)" +%s)
    now_time=$(date +%s)
    uptime_sec=$((now_time - boot_time))

    hours=$((uptime_sec / 3600))
    minutes=$(((uptime_sec % 3600) / 60))
    seconds=$((uptime_sec % 60))

    parts=()
    ((hours > 0)) && parts+=("$hours hour$([[ $hours != 1 ]] && echo s)")
    ((minutes > 0)) && parts+=("$minutes minute$([[ $minutes != 1 ]] && echo s)")
    ((seconds > 0)) && parts+=("$seconds second$([[ $seconds != 1 ]] && echo s)")

    uptime_output=$(IFS=','; echo "${parts[*]}" | sed 's/,/, /g')
else
    uptime_output=$(uptime -p)
fi

if $no_text; then
    echo "$uptime_output"
else
    echo "Uptime: $uptime_output"
fi
