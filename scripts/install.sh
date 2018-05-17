#!/bin/bash

# CURL Install

clear

sudo yum upgrade -y
sudo yum install epel-release -y 
sudo yum install dialog git wget vim whiptail -y 
sudo yum upgrade -y 

sudo rm -r /opt/rdisco

sudo git clone https://github.com/kaltec-w/reimagined-disco.git /opt/rdisco

sudo bash /opt/rdisco/menus/install_rdisco.sh
sudo bash /opt/rdisco/menus/main.sh