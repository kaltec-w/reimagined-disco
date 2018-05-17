#!/bin/bash

# CURL Install

clear

echo " --------------------------------------------------------------------- ";
echo " [ ! ]          C A U T I O N!           !C U I D A D O!          [ ! ]";
echo " --------------------------------------------------------------------- ";
echo "This script is about to *UPDATE* AND *UPGRADE* your OS. It is highly "
echo "  recommended that you deploy this on a new server, and not an existing"
echo "  one you may already be using. Running upgrades on an existing"
echo "  in-production server may break your environment and pre-existing setup"
echo "  of software, programs, scripts, applications, etc."
echo "";
echo "";
# read: safe shell input check. non-negated answer continues, else aborts.
read -p "Would you like to proceed updating and upgrading your OS and ALL packages? (Y/n) " -n 1 -r
echo    # move cursor to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "";
    echo "";
    echo "ABORTING per user request.";
    echo "";
    echo "";
    exit 1;
else
    echo "";# leave if statement and continue.
fi


sudo yum upgrade -y
sudo yum install epel-release -y 
sudo yum install dialog git wget vim whiptail -y 
sudo yum upgrade -y 

sudo rm -r /opt/rdisco

sudo git clone https://github.com/kaltec-w/reimagined-disco.git /opt/rdisco

sudo bash /opt/rdisco/menus/install_rdisco.sh
sudo bash /opt/rdisco/menus/main.sh