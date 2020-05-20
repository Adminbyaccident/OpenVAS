#!/usr/bin/bash

# This is a maintenance script to update OpenVAS sources on Debian 10.
# Modify it at your convenience.

# Instructions on how to use this script 

# chmod +x SCRIPTNAME.sh

# sudo ./SCRIPTNAME.sh

# Update Debian local repositories on this box.
apt update -y

# Upgrade the already installed packages on this box.
apt upgrade -y

# Update NVT sources info
greenbone-nvt-sync

# Update Scapdata sources info
greenbone-scapdata-sync

# Update Certdata sources info
greenbone-certdata-sync

# Restart OpenVAS Scanner
systemctl restart openvas-scanner

# Restart OpenVAS Manager
systemctl restart openvas-manager

# Rebuild NVT's cache and all the synced sources info
openvasmd --rebuild --progress

# Final message
echo "Maintenance tasks are now finished. Check for errors if any."

## EOF
