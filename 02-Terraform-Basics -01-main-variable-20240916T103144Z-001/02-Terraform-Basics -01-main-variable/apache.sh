#!/bin/bash

# Update and install Apache
sudo apt update -y
sudo apt install -y apache2

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Determine the server number and color
# This will be set when launching the EC2 instances
SERVER_NUM=$1

case $SERVER_NUM in
    1)
        COLOR="red"
        ;;
    2)
        COLOR="green"
        ;;
    3)
        COLOR="yellow"
        ;;
    *)
        COLOR="white"
        echo "Invalid server number. Using white as default." >&2
        ;;
esac

# Create the HTML file
echo "<html><body style='background-color:${COLOR};'><h1>Server ${SERVER_NUM} - ${COLOR} color</h1></body></html>" | sudo tee /var/www/html/index.html

# Log the result
echo "Apache installed and configured with ${COLOR} background for Server ${SERVER_NUM}" | sudo tee -a /var/log/user-data.log
