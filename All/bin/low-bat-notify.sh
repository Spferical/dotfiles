#!/usr/bin/env bash

while true; do
    percent=$(acpi -b | grep -P -o '[0-9]+(?=%)' | sort -n --reverse | head -n 1)
    if [ "${percent}" -le 10 ]; then
        notify-send -w -u critical  "Battery is low! - ${percent}%"
    fi
    sleep 60
done
