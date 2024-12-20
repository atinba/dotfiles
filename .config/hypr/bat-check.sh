#!/usr/bin/env bash

while true; do
  BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT*/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT*/status)

  if [ "$STATUS" -eq "Discharging"]; then
    dunstify -u 0 "Discharging" "Battery is discharging. Current level: ${BATTERY_LEVEL}%!"
  fi

  if [ "$BATTERY_LEVEL" -lt 20 ]; then
    dunstify -u 0 "Battery Low" "Battery level is at ${BATTERY_LEVEL}%!"
  fi

  sleep 100
done

