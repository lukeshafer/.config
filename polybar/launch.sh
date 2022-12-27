#!/bin/bash

# Terminate already running bar instances
killall -q polybar

for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar luke 2>&1 | tee -a /tmp/polybar.log & disown
done

echo "Polybar launched..."
