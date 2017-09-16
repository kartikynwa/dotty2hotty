#!/usr/bin/bash

# Script assigns random wallpaper when called.
# Wallpapers need to be placed in ~/wallpapers/
# Feh needs to be installed

files=(~/wallpapers/*)
feh --bg-scale "${files[$RANDOM % ${#files[@]}]}"
