#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
   sleep 1;
done

polybar --reload secondary -c ~/.config/polybar/config.ini

# # The main bar includes extra modules to see the time, weather, etc
# for m in $(polybar --list-monitors | grep "primary" | cut -d":" -f1); do
#    echo $m
#     MONITOR=$m polybar --reload main -c ~/.config/polybar/config.ini &
# done

# for m in $(polybar --list-monitors | grep -v "primary" | cut -d":" -f1); do
#     MONITOR=$m polybar --reload secondary -c ~/.config/polybar/config.ini &
# done
