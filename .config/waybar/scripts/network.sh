#!/bin/bash

# Get interface
iface=$(nmcli -t -f device,state connection show --active | head -n1 | cut -d: -f1)
[[ -z "$iface" ]] && { echo '{"text": "⚠ Disconnected"}'; exit; }

# 1. Live Speed (Kernel-basiert, sofortiger Wert)
read -r rx1 < /sys/class/net/"$iface"/statistics/rx_bytes
read -r tx1 < /sys/class/net/"$iface"/statistics/tx_bytes
sleep 0.5
read -r rx2 < /sys/class/net/"$iface"/statistics/rx_bytes
read -r tx2 < /sys/class/net/"$iface"/statistics/tx_bytes

# Calculate kB/s
down=$(((rx2 - rx1) * 2 / 1024))
up=$(((tx2 - tx1) * 2 / 1024))

# 2. Daily/Monthly Stats via vnstat
# (Falls vnstat keine Daten hat, wird "No data" angezeigt statt zu crashen)
stats=$(vnstat -i "$iface" --oneline | cut -d';' -f10,11,12,13 2>/dev/null || echo "No data")

# Prepare Icon/Name
icon="󰈀"; [[ "$iface" == *"wlan"* ]] && icon=""
name=$( [[ "$iface" == *"wlan"* ]] && nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2 || echo "$iface" )

# Print JSON
printf '{"text": "%s %s  %skB/s  %skB/s", "tooltip": "Stats: %s"}\n' "$icon" "$name" "$down" "$up" "$stats"
