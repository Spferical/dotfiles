#!/usr/bin/env bash

while true; do
    charging=0
    max_charge=0
    # There may be extra dead batteries or zombie batteries left over by a
    # suspend/resume. So, consider any charging or fullish battery ok.
    while read -r line; do
        [[ ${line} =~ ^Battery\ [0-9]+:\ ([a-zA-Z\ ]+),\ ([0-9]+)% ]]
        charge="${BASH_REMATCH[2]}"
        ((charge>max_charge)) && max_charge=${charge}
        if [[ "Charging" == "${BASH_REMATCH[1]}" ]]; then
            charging=1
        fi
    done < <(acpi -b)
    if [[ ${charging} == 0 && "${max_charge}" -le 10 ]]; then
        notify-send -w -u critical "Battery is low! - ${max_charge}%"
    fi
    sleep 60
done
