#!/bin/bash

errf() { printf "$@\n" >&2; exit 1; }
test_proc() { pidof "$@" &>/dev/null; }
test_cmd() { command -v $1 &>/dev/null; }
bgr() { nohup "$@" &>/dev/null & }

[[ ${EUID} == 0 ]] && errf "abort for root user"
test_cmd aria2c || aria2c

start_serv() {
    test_proc aria2c && exit 0
    local ddir=$(realpath ~/Downloads)
    # best_aria2, all_aria2, http_aria2, nohttp_aria2
    local trackers=$(curl -sL "https://cf.trackerslist.com/best_aria2.txt")
    local exec="aria2c --enable-rpc=true --rpc-secret=aria2rpc"
    exec+=" --rpc-listen-port=6800 --bt-stop-timeout=3600"
    exec+=" --dir=${ddir} --bt-tracker=${trackers}"
    bgr ${exec}
}

stop_serv() {
    local pid=$(pidof aria2c)
    [[ -z "${pid}" ]] || echo "${pid}" | xargs kill -9 &>/dev/null
}

case ${1} in
    ""|start)
        start_serv
        ;;
    stop)
        stop_serv
        ;;
    restart)
        stop_serv; start_serv
        ;;
    *)
        echo "Usage: $(basename ${0}) <start|stop|restart>"
        ;;
esac

