#! /bin/bash
#PATH=.xinitrc
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec i3
