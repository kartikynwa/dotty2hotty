#!/usr/bin/env bash

echo "This script places the config files in their designated folders"
echo "regardless of whether the program is installed or not."
echo ""
echo "This process is destructive in nature. Please consider the possibilities"
echo "before answering the following question."
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
    destination="${HOME}/${line##*DOT_DEST=}"
    if [ -e "${destination}" ]; then
      echo "${destination} already exists."
    else
      mkdir -pv "$(dirname "${destination}")"
      ln -vs "${PWD}/${filename}" "${destination}"
    fi
  else
    continue
  fi


done
