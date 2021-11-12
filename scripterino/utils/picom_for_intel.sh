#!/usr/bin/env sh

if glxinfo | grep -q Intel; then
  sv up ~/dotty2hotty/i3_services/picom
fi
