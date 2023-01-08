#! /bin/bash

# enable unattended upgrades

# https://wiki.debian.org/UnattendedUpgrades
# config: /etc/apt/apt.conf.d/20auto-upgrades
# test: sudo unattended-upgrade --debug --dry-run
# logfile: /var/log/unattended-upgrades/unattended-upgrades.log 

apt-get update
apt-get install -y unattended-upgrades apt-listchanges
dpkg-reconfigure -plow unattended-upgrades
echo 'APT::Periodic::AutocleanInterval "3";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo 'Unattended-Upgrade::Mail "support@mindsharestudios.com";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::MailOnlyOnError "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo "Testing automatic updates..."
echo
unattended-upgrade --debug --dry-run

