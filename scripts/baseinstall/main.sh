#!/bin/bash


############################################################ Basic Menu
if dialog --stdout --title "rDisco Install" \
  --backtitle "kaltec" \
  --yesno "\nWould you like to deploy rDisco:LibreNMS?" 7 50; then
  clear
else
  clear
  dialog --title "rDisco Install" \
  --msgbox "\nInstall cancelled. run rdisco again." 0 0
  clear
  echo "To restart installation, type: sudo rdisco"
  exit 0
fi

############################################################ Starting Installation
echo "8" | dialog --gauge "Conducting a System Update" 7 50 0
yum upgrade -y 1>/dev/null 2>&1
sleep 5

############################################################ Ansible Installation
echo "32" | dialog --gauge "Installing: Ansible Playbook" 7 50 0
yum install ansible -y 1>/dev/null 2>&1
sleep 5

############################################################ Start of Role Execution
echo "40" | dialog --gauge "Installing: rDisco Dependencies" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags preinstall 1>/dev/null 2>&1
sleep 5

echo "56" | dialog --gauge "Installing: rDisco MOTD" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags motd 1>/dev/null 2>&1
sleep 5

############################################################ Docker Install
docker --version | awk '{print $3}' > /var/rdisco/docker.version
docker_var=$( cat /var/rdisco/docker.version )

if [ "$docker_var" == "18.03.1-ce," ]
then
  echo "64" | dialog --gauge "Docker Is Already Installed" 7 50 0
  sleep 5
else
  echo "64" | dialog --gauge "Installing: Docker 18.03 (Please Be Patient)" 7 58 0
  ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags docker 1>/dev/null 2>&1
  sleep 5
fi

############################################################ Portainer Install
echo "72" | dialog --gauge "Installing: Portainer" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags portainer &>/dev/null &
sleep 5

echo "80" | dialog --gauge "Forcing Reboot of Existing Containers!" 7 50 0
bash /opt/rdisco/scripts/containers/reboot.sh &>/dev/null &
sleep 5

echo "88" | dialog --gauge "Installing: WatchTower" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags watchtower &>/dev/null &
sleep 5


echo "100" | dialog --gauge "Installation Complete!" 7 50 0
sleep 5

cat /var/rdisco/rdisco.preinstall > /var/rdisco/rdisco.preinstall.stored
clear