#! /bin/bash
#PATH=.xinitrc
xrdb -load ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
~/dotty2hotty/scripterino/wall.sh
unclutter &
compton &
redshift &
# slstatus &
start-pulseaudio-x11 &
xmodmap ~/.xmodmaprc
exec i3
