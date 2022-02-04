#!/usr/bin/env bash
# Like 'git log' but for nix system configurations.

diff() {
    ns=($(find /nix/var/nix/profiles/system-*-link | grep -Eo '[0-9]+' | sort -g -r))
    len=${#ns[@]}
    for i in $(seq 0 $((len-2))); do
        nvd --color=always diff \
            /nix/var/nix/profiles/system-{"${ns[$((i+1))]}","${ns[$i]}"}-link
    done
}

diff | "${PAGER}"
