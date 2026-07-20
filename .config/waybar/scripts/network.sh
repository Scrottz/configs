#!/bin/bash

# Get the active interface name
iface=$(nmcli -t -f device,state connection show --active | head -n1 | cut -d: -f1)

if [[ -z "$iface" ]]; then
    echo '{"text": "⚠ Disconnected", "tooltip": "No connection"}'
    exit
fi

# Get live speed via vnstat (live mode for 1 second)
# We grep the line that contains the rates and format it
live=$(vnstat -tr 1 -i "$iface" | grep "rx" | awk '{print " " $2 $3 "  " $5 $6}')

# Get stats for daily and monthly
stats=$(vnstat -d -m -i "$iface" | grep -E "day|month" | awk '{print $1, $2, $3, $4, $5}' | sed 's/|//g')

# Prepare SSID or interface name
if [[ "$iface" == *"wlan"* ]]; then
    name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    icon=""
else
    name="$iface"
    icon="󰈀"
fi

# Print JSON for Waybar
# We use \n in tooltip for nice formatting
echo "{\"text\": \"$icon $name $live\", \"tooltip\": \"Stats ($name):\n$stats\"}"
