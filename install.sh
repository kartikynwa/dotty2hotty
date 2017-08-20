#!/bin/bash

# A script to install dotfiles. I will keep it simple.

echo "This will install ksynwa's dotfiles for:"
echo "  - xinitrc"
echo "  - i3, polybar, rofi, compton"
echo "  - zsh+zprezto, termite"
echo "  - nvim+dein"
echo "Ensure that ^ have been installed. Pls."
echo "Proceed?"

read input

if [ ! "$input" == "y" ]; then
    echo "Good choice, mate."
    exit
fi

files="compton i3 nvim rofi polybar termite zshrc"

echo "You seem okay. Let us backup your old files."

mkdir -p backup

for file in $files; do
    linkpath=$HOME/`head -1 $file | cut -d "=" -f 2`
    configpath=$PWD/$file
    if [ -f $path ]; then
         mv $linkpath backup/$file
        echo "$linkfile has been backed up."
    else
        echo "$linkfile config file MIA."
    fi
    ln -s $configpath $linkpath
    echo "Symlink created for $file."
done

echo "How neat is that!"
