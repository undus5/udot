#!/bin/bash

errf() { printf "$@\n" >&2 && exit 1; }
test_cmd() { command -v $1 &>/dev/null || errf "command not found: $1" }

usage="Usage: $(basename ${0}) <host_nameame> <a|b|d|t|s>"
host_name="$1"
dirs="$2"

get_dev_ip() {
    local dev_name=$host_name
    [[ -n "${dev_name}" ]] || errf "Usage: $(basename ${0}) <device_name>"
    # dev_mac=${!dev_name}
    declare -n dev_mac=${dev_name^^}
    [[ -n "$dev_mac" ]] || errf "undefined device: $dev_name"

    # setcap cap_net_raw=eip /usr/bin/arp-scan
    test_cmd arp-scan || errf "command not found: arp-scan"
    # ip link | grep brnat | grep -q "state UP" \
    #     && arp-scan -x -l -I brnat | grep ${dev_mac} | awk '{ print $1 }'
    ip link | grep brlan | grep -q "state UP" \
        && arp-scan -x -l -I brlan | grep ${dev_mac} | awk '{ print $1 }'
}

test_host_ip() {
    local host_ip="$1"
    [[ -n "${host_ip}" ]] || errf "invalid host_name: $host_name"
}

sync_dir() {
    # [[ "${1}" =~ ^[abdt]$ ]] || errf "${usage}"
    local dir=~/${1}/
    local host_ip=$(get_dev_ip)
    test_host_ip $host_ip
    rsync -aP --del $dir ${host_ip}:${dir}
}

case "$dirs" in
    s)
        host_ip=$(get_dev_ip)
        test_host_ip $host_ip
        ssh $host_ip
        ;;
    *)
        # empty check
        [[ -n "$dirs" ]] || errf "$usage"
        # remove duplicates
        dirs=$(echo "$dirs" | grep -o . | sort -u | tr -d '\n')
        # validate dirs
        [[ "$dirs" =~ ^[abdt]+$ ]] || errf "$usage"
        # split dirs
        for (( i=0; i<${#dirs}; i++ )); do
            d="${dirs:i:1}"
            [[ "$d" =~ ^[abdt]$ ]] || errf "$usage"
            sync_dir "$d"
        done
        ;;
esac

