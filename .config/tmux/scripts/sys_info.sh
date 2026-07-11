#!/bin/bash

# Calculate CPU load
read cpu_user_old cpu_nice_old cpu_sys_old cpu_idle_old < <(grep '^cpu ' /proc/stat | awk '{print $2, $3, $4, $5}')
sleep 0.2
read cpu_user_new cpu_nice_new cpu_sys_new cpu_idle_new < <(grep '^cpu ' /proc/stat | awk '{print $2, $3, $4, $5}')
cpu_idle_delta=$((cpu_idle_new - cpu_idle_old))
cpu_total_delta=$(( (cpu_user_new + cpu_nice_new + cpu_sys_new + cpu_idle_new) - (cpu_user_old + cpu_nice_old + cpu_sys_old + cpu_idle_old) ))
cpu_load=$(( 100 * (cpu_total_delta - cpu_idle_delta) / cpu_total_delta ))

# Get temperature and memory usage
temp_c=$(( $(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo 0) / 1000 ))
mem_usage=$(( 100 * ($(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {print t-a}' /proc/meminfo)) / $(awk '/MemTotal/ {print $2}' /proc/meminfo) ))

# Get network speeds
net_cache="/tmp/tmux_net_cache"
read rx_old tx_old < <(cat "$net_cache" 2>/dev/null || echo "0 0")
read rx_new tx_new < <(awk '/eth|enp|wlp/ {rx+=$2; tx+=$10} END {print rx, tx}' /proc/net/dev)
echo "$rx_new $tx_new" > "$net_cache"
rx_speed=$(( (rx_new - rx_old) / 1024 / 5 ))
tx_speed=$(( (tx_new - tx_old) / 1024 / 5 ))

# Define colors based on thresholds
temp_color="colour245"
[ "$temp_c" -gt 85 ] && temp_color="colour160"
mem_color="colour245"
[ "$mem_usage" -gt 90 ] && mem_color="colour160"

# display_str: With tmux color tags for rendering
display_str="#[fg=colour33]CPU:${cpu_load}% #[fg=$temp_color]${temp_c}°C #[fg=$mem_color]RAM:${mem_usage}% #[fg=colour245]|  ${rx_speed}KB/s  ${tx_speed}KB/s"

# clean_str: Plain text only, for width calculation (no tmux tags)
clean_str="CPU:${cpu_load}% ${temp_c}°C RAM:${mem_usage}% |  ${rx_speed}KB/s  ${tx_speed}KB/s"

# Output joined by pipe
echo "$display_str|$clean_str"

