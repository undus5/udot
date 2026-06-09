#!/bin/bash

bgr() { nohup "$@" &>/dev/null & }

rm -rf ~/.local/share/fcitx5/rime/build
bgr fcitx5 -d -r

