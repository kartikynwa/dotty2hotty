#!/bin/bash

# A script to install dotfiles. I will keep it simple.

echo "This will install ksynwa's dotfiles for:"
echo "  - i3, polybar, rofi, compton"
echo "  - zsh+zprezto, termite"
echo "  - nvim+dein"
echo "  - xinitrc"
echo "Ensure that ^ have been installed. Pls."
echo "Proceed?"

read input

if [ ! "$input" == "y" ]; then
    echo "Good choice, mate."
    exit
fi

files="compton i3 nvim rofi polybar termite zshrc xinitrc Xresources"

echo "You seem okay. Let us backup your old files."

mkdir -p backup

for file in $files; do
    linkpath=$HOME/`head -2 $file | tail -1 | cut -d "=" -f 2`
    configpath=$PWD/$file
    if [ -f $path ]; then
        mv $linkpath backup/$file
        echo "$file config has been backed up."
    else
        echo "$linkfile config file MIA."
    fi
    ln -s $configpath $linkpath
    echo "Symlink created for $file."
done

echo "How neat is that!"
