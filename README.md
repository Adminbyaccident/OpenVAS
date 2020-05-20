# OpenVAS
OpenVAS installation and maintenance scripts


## The openvas_debian10.sh script
This script will install the OpenVAS vulnerability scanner on a Debian 10 system.
The firewall is enabled using UFW and open ports are 22 for SSH and 9392 for OpenVAS's web panel.

## The openvas_maintenance_debian10.sh script
This one is just for sources updates. Run it periodically using cron so sources are always synchronized.
