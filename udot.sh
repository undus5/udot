#!/bin/bash

errf() { printf "$@\n" >&2; exit 1; }
# replace '/home/*' with '~' in path for display
tilde_path() { echo "$1" | sed "s#$(realpath ~)#~#"; }

self_dir=$(dirname $(realpath ${BASH_SOURCE[0]}))
conf_dir=~/.config

test_names() {
    local names=()
    if [[ "$1" == "all" ]]; then
        mapfile -t names < <(find $self_dir -mindepth 1 -maxdepth 1 -type d \
            ! -name ".git" \
            ! -name "kanshi" \
            -exec basename '{}' \;)
    else
        for n in "$@"; do
            n=${n%/}
            [[ -d ${self_dir}/${n} ]] || errf "name not found: $n"
            [[ "$n" != "kanshi" ]] && names+=("$n")
        done
    fi
    echo "${names[@]}"
}

deploy_config() {
    local n="$1"
    if [[ -d ${conf_dir}/${n} ]]; then
        rm -rf ${conf_dir}/${n}
        echo "==> removed '$(tilde_path ${conf_dir}/${n})'"
    fi
    cp -rf ${self_dir}/${n} ${conf_dir}/${n}
    echo "==> installed '$(tilde_path ${conf_dir}/${n})'"
}

merge_config() {
    local n="$1"
    if [[ -d ${conf_dir}/${n} ]]; then
        rm -rf ${self_dir}/${n}
        cp -rf ${conf_dir}/${n} ${self_dir}/${n}
        echo "==> merged '$(tilde_path ${self_dir}/${n})'"
    fi
}

deploy_lite_xl() {
    local path="lite-xl/init.lua"
    cp -f ${self_dir}/${path} ${conf_dir}/${path}
}

merge_lite_xl() {
    local path="lite-xl/init.lua"
    cp -f ${conf_dir}/${path} ${self_dir}/${path}
}

case "$1" in
    deploy)
        shift
        names=$(test_names "$@")
        [[ -n "$names" ]] || errf "empty names"
        for n in "${names[@]}"; do
            if [[ "$n" == "lite-xl" ]]; then
                deploy_lite_xl
            else
                deploy_config $n
            fi
        done
        ;;
    merge)
        shift
        names=$(test_names "$@")
        [[ -n "$names" ]] || errf "empty names"
        for n in "${names[@]}"; do
            if [[ "$n" == "lite-xl" ]]; then
                merge_lite_xl
            else
                merge_config $n
            fi
        done
        ;;
    *)
        errf "Usage: $(basename $0) <deploy|merge>"
        ;;
esac

