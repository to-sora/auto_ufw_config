#!/bin/bash

# Paths to the configuration files
IP_CONFIG_FILE="/install/ufw_config/ip_whitelist.conf"
PORT_CONFIG_FILE="/install/ufw_config/port_whitelist.conf"

# Read port list into an array
mapfile -t ports < "$PORT_CONFIG_FILE"

# Read each IP and apply rules for each port
while IFS= read -r ip
do
    if [[ -n "$ip" ]]; then
        for port in "${ports[@]}"
        do
            echo "Allowing $ip on port $port"
            ufw allow from $ip to any port $port
        done
    fi
done < "$IP_CONFIG_FILE"

# Enable the firewall rules, if not already enabled
ufw enable
