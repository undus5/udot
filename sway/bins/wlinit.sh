#!/usr/bin/bash

chkcmd() { command -v "${@}" &>/dev/null; }
chksrv() { pidof "${@}" &>/dev/null; }
bgr() { nohup "${@}" &>/dev/null & }

chkcmd kanshi && ! chksrv kanshi && bgr kanshi
chkcmd fcitx5 && ! chksrv fcitx5 && bgr fcitx5 -d -r

polkit_name=polkit-mate-authentication-agent-1
polkit_arch=/usr/lib/mate-polkit/${polkit_name}
polkit_fedora=/usr/libexec/${polkit_name}
[[ -f "${polkit_arch}" ]] && polkit_exec="${polkit_arch}"
[[ -f "${polkit_fedora}" ]] && polkit_exec="${polkit_fedora}"
chkcmd ${polkit_exec} && ! chksrv ${polkit_name} && bgr ${polkit_exec}

gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

if [[ -n "${SWAYSOCK}" && -d ~/.icons/Qogir-Dark ]]; then
    swaymsg seat seat0 xcursor_theme Qogir-Dark 32
fi

if [[ -d ~/.icons/Qogir ]]; then
    gsettings set org.gnome.desktop.interface icon-theme Qogir
fi

bgname=~/Pictures/wallpaper
bgfile=${bgname}.png
[[ -f "${bgfile}" ]] || bgfile=${bgname}.jpg
[[ -f "${bgfile}" ]] || bgfile=${bgname}.webp
if [[ -f "${bgfile}" ]]; then
    chksrv swaybg && pidof swaybg | xargs kill -9
    bgr swaybg -m fill -i "${bgfile}"
fi

# put in bashrc
[[ -z "$LS_COLORS" ]] && eval $(dircolors -b)
# https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]] && exec sway

