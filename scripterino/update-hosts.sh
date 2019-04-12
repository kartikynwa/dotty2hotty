#!/usr/bin/env sh

distracted=true

curl 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' > /etc/hosts

if [ $distracted = true ]; then
  cat ../config_files/distraction_hosts >> /etc/hosts
fi
