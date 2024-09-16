#!/bin/bash

# Stop the Apache service
sudo systemctl stop apache2

# Disable Apache from starting on boot
sudo systemctl disable apache2

# Remove Apache and its dependencies
sudo apt remove apache2 apache2-utils apache2-bin -y

# Remove configuration files
sudo apt purge apache2 apache2-utils apache2-bin -y

# Remove any remaining dependencies that are no longer needed
sudo apt autoremove -y

# Clean up any remaining Apache-related files
sudo rm -rf /etc/apache2
sudo rm -rf /var/www/html

# Remove Apache log files
sudo rm -rf /var/log/apache2

# Remove user-data log file created in the original script
sudo rm -f /var/log/user-data.log

echo "Apache has been uninstalled and cleaned up."

# Optional: Check if Apache is still installed
if ! command -v apache2 &> /dev/null; then
    echo "Apache is no longer installed on the system."
else
    echo "Warning: Apache might still be partially installed. Please check manually."
fi
