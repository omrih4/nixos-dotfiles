#!/usr/bin/env bash

while ! pidof "hyprpaper" > /dev/null; do
  sleep 1
done

sleep 1
DAYTIME_WALLPAPER=~/Pictures/Wallpapers/day.png
NIGHTTIME_WALLPAPER=~/Pictures/Wallpapers/night.png

PRESENT_TIME=$(date +%H)

if [ $PRESENT_TIME -ge 6 ] && [ $PRESENT_TIME -lt 18 ]; then
	WALLPAPER=$DAYTIME_WALLPAPER
else
	WALLPAPER=$NIGHTTIME_WALLPAPER
fi

hyprctl hyprpaper preload "$WALLPAPER"

hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"
