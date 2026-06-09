#!/bin/bash

errf() { printf "${@}" >&2; exit 1; }

gethelp() {
    echo "Usage: [-i|-c|w:h,dar] file1 file2 ..."
    echo "  -i       get video info"
    echo "  -c       concat without reencoding"
    echo "  w:h,dar  concat with reencoding, e.g. 1920:1080,16/9"
}

getinfo() {
    [[ -f "${1}" ]] || errf "file not found: ${1} \n"
    ffprobe -v error -select_streams v \
        -show_entries stream=width,height,display_aspect_ratio \
        -of csv=p=0:s=, "${1}"
}

if [[ -z "${1}" || "${1}" == "-h" ]]; then
    gethelp
    exit 0
fi

if [[ "${1}" == "-i" ]]; then
    shift
    for v in "${@}"; do
        printf "$(basename ${v})  "
        getinfo "${v}"
    done
    exit 0
fi

if [[ "${1}" == "-c" ]]; then
    shift
    list=$(mktemp)
    for v in "${@}"; do
        [[ -f "${v}" ]] || errf "file not found: $(basename ${v})\n"
        echo "file $(realpath ${v})" >> ${list}
    done
    ffmpeg -f concat -safe 0 -i ${list} -c copy vmerged.mp4
    exit 0
fi

if [[ "${1}" =~ ^[0-9]{3,4},[0-9]{3,4}$ ]]; then
    res=${1}
elif [[ "${1}" =~ ^[0-9]{3,4}x[0-9]{3,4},[0-9]{1,2}/[0-9]{1,2}$ ]]; then
    res=$(echo "${1}" | cut -d ',' -f 1)
    dar=$(echo "${1}" | cut -d ',' -f 2)
else
    errf "invalid arguments: ${1}\n"
fi
shift

(( ${#} > 0 )) || errf "empty file list\n"
vopts=
concat=
finputs=
for ((i=0; i<${#}; i++)); do
    ii=$((i+1))
    f=${!ii}
    [[ -f "${f}" ]] || errf "file not found: $(basename ${f})\n"
    finputs+=" -i ${f}"
    vopts+="[${i}:v]scale=${res}"
    [[ -n "${dar}" ]] && vopts+=",setdar=${dar}"
    vopts+="[v${i}];"
    concat+="[v${i}][${i}:a]"
done

concat+="concat=n=${#}:v=1:a=1[outv][outa]"

ffmpeg $finputs -filter_complex "${vopts}${concat}" \
    -map "[outv]" -map "[outa]" -crf 23 -c:v libx265 -c:a aac \
    vmerged.mp4

