#!/usr/bin/env bash
# Like 'git log' but for nix system configurations.

diff() {
    ns=($(echo /nix/var/nix/profiles/system-*-link | grep -Eo '[0-9]+' | sort -g -r))
    len=${#ns[@]}
    interrupted=0
    on_interrupt() {
        interrupted=1
    }
    trap on_interrupt SIGINT
    for i in $(seq 0 $((len-2))); do
        [[ interrupted -ne 0 ]] && { echo "Ctrl-C caught, exiting..." ; exit ; }
        local new="/nix/var/nix/profiles/system-${ns[$((i+1))]}-link"
        local old="/nix/var/nix/profiles/system-${ns[$i]}-link"
        echo "${new} built $(stat -c %y $new)"
        nvd --color=always diff "${new}" "${old}"
    done
}

diff | "${PAGER}"
