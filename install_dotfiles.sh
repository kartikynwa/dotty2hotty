#!/usr/bin/env sh

echo "This script symlinks the dotfiles to their respective paths."
echo "Please verify the scripe before running it."
echo ""
while true; do
  read -rp "Do you wish to proceed? " yn
  case $yn in
    [Yy]* ) echo "Alright, friend."; break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo ""

if [ -d ~/dotty2hotty ];
then
  cd ~/dotty2hotty || exit
else
  echo "ERROR: This script kinda sucks and only works if the git repo is"
  echo "cloned in the home directory."
  exit
fi

for filename in dotfiles/*;
do
  [ -f "${filename}" ] || continue
  line=$( grep -m 1 "DOT_DEST=" "${filename}" )

  if [ -n "${line}" ];
  then
    _destination=${line##*DOT_DEST=}
    destination="${HOME}/${_destination%\ *}"
    if [ -e "${destination}" ]; then
      echo "${destination}: Already exists. No changes made."
    else
      mkdir -pv "$(dirname "${destination}")"
      ln -vs "${PWD}/${filename}" "${destination}"
    fi
  else
    continue
  fi


done
