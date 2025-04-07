#!/usr/bin/env bash

while true; do
  BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT*/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT*/status)

  if [ "$STATUS" == "Discharging" ] ; then
    dunstify -u 0 "Discharging" "Battery is discharging. Current level: ${BATTERY_LEVEL}%!"
  elif [ "$BATTERY_LEVEL" -lt 30 ]; then
    dunstify -u 0 "Battery Low" "Battery level is at ${BATTERY_LEVEL}%!"
  fi

  sleep 100
done

