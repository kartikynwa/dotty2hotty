#!/usr/bin/env sh

HOSTFILEURL="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" 

HOSTFILE=$(curl -f "$HOSTFILEURL" 2> /dev/null)

while [ $? -ne 0 ]; do
  sleep 1h
  HOSTFILE=$(curl -f "$HOSTFILEURL" 2> /dev/null)
done

DISTRACTIONS="
# [Distraction]
0.0.0.0 reddit.com     
0.0.0.0 i.reddit.com
0.0.0.0 v.reddit.com  
0.0.0.0 www.reddit.com
0.0.0.0 m.reddit.com
0.0.0.0 api.reddit.com
# 0.0.0.0 imgur.com
# 0.0.0.0 i.imgur.com
"

echo "${HOSTFILE}\n${DISTRACTIONS}" > /etc/hosts
