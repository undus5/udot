#!/bin/bash

errf() { printf "$@\n" >&2; exit 1; }

pdir=$1
[[ -d $pdir ]] || errf "Usage: $(basename $0) <looking_glass_src_dir> [git]"
cdir=${pdir}/client
[[ -d $cdir ]] || errf "not a looking glass project"

git=$2
if [[ -n "$git" ]]; then
    edir=$(find "${pdir}/repos/wayland-protocols" -maxdepth 0 -empty)
    cd ${pdir}
    if [[ -z "${edir}" ]]; then
        git submodule update --init --recursive
    else
        git submodule update --remote --recursive
    fi
fi

bdir=${cdir}/build
[[ -d $bdir ]] || mkdir $bdir

cmake \
    -DENABLE_X11=no \
    -DENABLE_PULSEAUDIO=no \
    -DENABLE_BACKTRACE=no \
    -B ${bdir} -S ${cdir}

cd $bdir; make

# dependencies for Fedora:

# cmake
# make
# pkgconf-pkg-config
# gcc-c++
# fontconfig-devel
# nettle-devel
# spice-protocol
# wayland-devel
# libxkbcommon-devel
# mesa-libEGL-devel
# mesa-libGL-devel
# pipewire-devel
# libsamplerate-devel

