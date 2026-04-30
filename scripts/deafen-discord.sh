#!/usr/bin/env bash
# vibe coded script to toggle deafening discord :sob:

mapfile -t PIDS < <(pgrep -f vesktop)

[ "${#PIDS[@]}" -eq 0 ] && notify-send "Discord not running" --expire-time=1500 && exit 1

mapfile -t STREAM_IDS < <(
    wpctl status | grep -oP '^\s*\K[0-9]+(?=\.)' | while read -r ID; do
        pid=$(wpctl inspect "$ID" 2>/dev/null | grep -oP 'application\.process\.id = "\K[^"]+')
        [[ " ${PIDS[*]} " == *" $pid "* ]] && echo "$ID"
    done
)

[ "${#STREAM_IDS[@]}" -eq 0 ] && notify-send "Discord audio not found" --expire-time=1500 && exit 1

for ID in "${STREAM_IDS[@]}"; do
      	wpctl set-mute "$ID" toggle;
	MUTED=$(wpctl get-volume "$ID" | grep -o '\[MUTED\]')
done
if [[ -n "$MUTED" ]]; then
  notify-send "Discord muted 🔇" --expire-time=1500
else
  notify-send "Discord unmuted 🔊" --expire-time=1500
fi
