#!/bin/bash
# PATH=$HOME/.xinitrc
xrdb -load ~/.Xresources
~/dotty2hotty/scripterino/wall.sh
unclutter &
compton &
# slstatus &
start-pulseaudio-x11 &
xset -b
[ -f ~/dotty2hotty/xmodmaprc ] && xmodmap ~/dotty2hotty/xmodmaprc
export QT_QPA_PLATFORMTHEME=gtk2
exec i3
