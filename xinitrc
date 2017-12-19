#! /bin/bash
#PATH=.xinitrc
xrdb -merge ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
~/dotty2hotty/scripterino/wall.sh
unclutter &
compton &
slstatus &
redshift &
xmodmap ~/.xmodmaprc
exec dwm
