#!/usr/bin/bash

# This is an install script to install OpenVAS on Debian 10.
# Modify it at your convenience.

# Instructions on how to use this script 

# chmod +x SCRIPTNAME.sh

# sudo ./SCRIPTNAME.sh

# Update Debian local repositories on this box.
apt update -y

# Upgrade the already installed packages on this box.
apt upgrade -y

# Install UFW firewall
apt install ufw -y

# Enable port 22 (for the SSH service) on the UFW firewall.

ENABLE_UFW_22=$(expect -c "
set timeout 2
spawn ufw enable
expect \"Command may disrupt existing ssh connections. Proceed with operation (y|n)?\"
send \"y\r\"
expect eof
")
echo "ENABLE_UFW_22"

# Install OpenVAS
apt install openvas -y

# Update OpenVAS sources
openvas-setup

# Install network-tools
apt install net-tools -y

# Get the system's ip in a variable named 'ip'
ipvar=$(ifconfig | grep "inet " | awk '{ print $2; exit }')

# Configure the greenbone-security-assistant.service entry on systemd
# This will allow allow anyone to visit the server ip and work with OpenVAS
sed -i 's/127.0.0.1/0.0.0.0/g' /lib/systemd/system/greenbone-security-assistant.service
sed -i "s/mport=9390/mport=9390 --allow-header-host $ipvar/g" /lib/systemd/system/greenbone-security-assistant.service

# Reload systemd with the new configuration settings for greenbone-security-assistant.service
systemctl daemon-reload

# Restart the greenbone-security-assistant.service service
systemctl restart greenbone-security-assistant.service

# Enable port 9392 for OpenVAS to be used through the web panel
ufw allow 9392

# Display installation final message
echo "OpenVAS has been installed. The admin user password is in the bottom part of the installation output"
