#!/bin/bash
set -ex

hostname dnsserver

apt update
apt -y upgrade
apt -y install bind9

ufw allow Bind9

rm /etc/bind/named.conf.options
ln -s /vagrant/scripts/named.conf.options /etc/bind/named.conf.options


rm /etc/bind/named.conf.local
ln -s /vagrant/scripts/named.conf.local /etc/bind/named.conf.local

ln -s /vagrant/scripts/db.devops /etc/bind/db.devops

/etc/init.d/bind9 restart


IP=$(ip address | grep -P "inet 192." | sed -e "s#.*\(192.*\)/.*#\1#")
echo "      nameservers:" >> /etc/netplan/50-vagrant.yaml
echo "         addresses: [$IP]" >> /etc/netplan/50-vagrant.yaml

netplan apply

# Important: Symlinks are not working with default app armor, this has to be fixed by adding a profile or not symlinking 
systemctl disable apparmor
reboot