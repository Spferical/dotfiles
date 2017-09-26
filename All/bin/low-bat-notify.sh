#!/bin/bash

# low battery in %
LOW_BATTERY="10"
# path to battery /sys
BATTERY_PATH="/sys/class/power_supply/BAT0/"

while true; do
	if [ -e "$BATTERY_PATH" ]; then
	    BATTERY_ON=$(cat $BATTERY_PATH/status)
	    if [ "$BATTERY_ON" != "Charging" ]; then
		CURRENT_BATTERY=$(cat $BATTERY_PATH/capacity)
		if [ "$CURRENT_BATTERY" -lt "$LOW_BATTERY" ]; then
		    notify-send -u critical  "Battery is low! - $CURRENT_BATTERY%"
		fi
	    fi
	fi
	sleep 60
done
