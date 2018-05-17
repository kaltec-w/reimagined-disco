#!/bin/bash

# CURL Install

echo "Installing rDisco - LibreNMS Edition"
yum upgrade -y 1>/dev/null 2>&1
yum install epel-release -y 1>/dev/null 2>&1
yum install dialog git wget vim whiptail -y 1>/dev/null 2>&1
yum install ansible -y 1>/dev/null 2>&1
yum upgrade -y 1>/dev/null 2>&1

rm -r /opt/rdisco/librenms

