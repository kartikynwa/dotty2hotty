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
  echo "mate what are you trying to do?"
  exit
fi

for FILE in ./*;
do
  [ -f $FILE ] || continue
  LINE=`sed '2q;d' $FILE`

  if [[ $LINE = *"PATH="* ]];
  then
    TARGET=${LINE##*PATH=}
    ls $TARGET
  else
    continue
  fi


done
