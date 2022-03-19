#!/bin/bash
set -ex

hostname dnsserver

apt update
apt -y upgrade
apt -y install bind9

ufw allow Bind9