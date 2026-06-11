#!/bin/bash

errf() { printf "$@\n" >&2; exit 1; }
# replace '/home/*' with '~' in path for display
tilde_path() { echo "$1" | sed "s#$(realpath ~)#~#"; }

self_dir=$(dirname $(realpath ${BASH_SOURCE[0]}))
conf_dir=~/.config

test_names() {
    local names=()
    for n in "$@"; do
        n=${n%/}
        [[ -d ${self_dir}/${n} ]] || errf "name not found: $n"
        [[ "$n" != "kanshi" ]] && names+=("$n")
    done
    echo "${names[@]}"
}

case "$1" in
    deploy)
        shift
        names=$(test_names "$@")
        [[ -n "$names" ]] || errf "empty names"
        for n in "${names[@]}"; do
            if [[ -d ${conf_dir}/${n} ]]; then
                rm -rf ${conf_dir}/${n}
                echo "==> removed '$(tilde_path ${conf_dir}/${n})'"
            fi
            cp -rf ${self_dir}/${n} ${conf_dir}/${n}
            echo "==> installed '$(tilde_path ${conf_dir}/${n})'"
        done
        ;;
    merge)
        shift
        names=$(test_names "$@")
        [[ -n "$names" ]] || errf "empty names"
        for n in "${names[@]}"; do
            if [[ -d ${conf_dir}/${n} ]]; then
                rm -rf ${self_dir}/${n}
                cp -rf ${conf_dir}/${n} ${self_dir}/${n}
                echo "==> merged '$(tilde_path ${self_dir}/${n})'"
            fi
        done
        ;;
    *)
        errf "Usage: $(basename $0) <deploy|merge>"
        ;;
esac

