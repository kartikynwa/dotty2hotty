#!/usr/bin/bash

# Script assigns random wallpaper when called.
# Wallpapers need to be placed in ~/dotty2hotty/wallpapers/
# Feh needs to be installed

files=(~/dotty2hotty/wallpapers/*)
feh --bg-scale "${files[$RANDOM % ${#files[@]}]}"
