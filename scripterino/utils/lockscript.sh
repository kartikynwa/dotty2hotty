#!/usr/bin/env sh
screenshot=/tmp/i3lock-screenshot.png
maim "${screenshot}"
mogrify -scale 10% -scale 1000% "${screenshot}"
i3lock -i "${screenshot}"
