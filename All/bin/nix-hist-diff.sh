#!/usr/bin/env bash
# Like 'git log' but for nix system configurations.

diff() {
    local ns
    ns=($(echo /nix/var/nix/profiles/system-*-link | grep -Eo '[0-9]+' | sort -g -r))
    local len=${#ns[@]}
    local interrupted=0
    on_interrupt() {
        interrupted=1
    }
    trap on_interrupt SIGINT
    for i in $(seq 0 $((len-2))); do
        [[ interrupted -ne 0 ]] && { echo "Ctrl-C caught, exiting..." ; exit ; }
        local old="/nix/var/nix/profiles/system-${ns[$((i+1))]}-link"
        local new="/nix/var/nix/profiles/system-${ns[$i]}-link"
        local newdate
        newdate=$(stat -c %y "${new}")
        echo "${new} built ${newdate})"
        nvd --color=always diff "${old}" "${new}"
    done
}

diff | "${PAGER}"
