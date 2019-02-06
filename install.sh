#!/usr/bin/env bash

echo "This script places the config files in their designated folders"
echo "regardless of whether the program is installed or not."
echo ""
echo "This process is destructive in nature. Please consider the possibilities"
echo "before answering the following question."
echo ""
while true; do
  read -p "Do you wish to proceed? " yn
  case $yn in
    [Yy]* ) echo "Alright, friend."; break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo ""

if [ -d ~/dotty2hotty ];
then
  cd ~/dotty2hotty
else
  echo "ERROR: This script kinda sucks and only works if the git repo is"
  echo "cloned in the home directory."
  exit
fi

for FILENAME in dotfiles/*;
do
  [ -f ${FILENAME} ] || continue
  LINE=$( grep -m 1 DEST= ${FILENAME} )

  if [ -n "${LINE}" ];
  then
    TARGET=${LINE##*DEST=}
    TARGET="${HOME}/${TARGET}"
    echo $TARGET
    if [ -e ${TARGET} ]; then
      echo "${TARGET} already exists. Please resolve this fucktangle."
    else
      mkdir -pv $(dirname ${TARGET})
      ln -s ${PWD}/${FILENAME} ${TARGET}
    fi
  else
    continue
  fi


done
