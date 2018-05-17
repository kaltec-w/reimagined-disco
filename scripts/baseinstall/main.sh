#!/bin/bash


############################################################ Basic Menu
if dialog --stdout --title "rDisco Install" \
  --backtitle "kaltec" \
  --yesno "\nWould you like to install rDisco?" 7 50; then
  clear
else
  clear
  dialog --title "rDisco Install" \
  --msgbox "\nInstall cancelled. run rdisco again." 0 0
  echo "To restart installation, type: sudo rdisco"
  exit 0
fi

############################################################ Starting Installation
echo "0" | dialog --gauge "Conducting a System Update" 7 50 0
yum upgrade -y 1>/dev/null 2>&1

echo "18" | dialog --gauge "Enabling System Health Monitoring" 7 50 0
yum install sysstat nmon -y 1>/dev/null 2>&1
sed -i 's/false/true/g' /etc/default/sysstat 1>/dev/null 2>&1

############################################################ Ansible Installation
echo "22" | dialog --gauge "Installing: Ansible Playbook" 7 50 0
yum install ansible -y 1>/dev/null 2>&1

############################################################ Start of Role Execution
echo "26" | dialog --gauge "Installing: rDisco Dependencies" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags preinstall 1>/dev/null 2>&1

echo "30" | dialog --gauge "Installing: rDisco Commands" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags commands &>/dev/null &
sleep 2

echo "43" | dialog --gauge "Installing: rDisco MOTD" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags motd 1>/dev/null 2>&1

############################################################ Docker Install
docker --version | awk '{print $3}' > /var/rdisco/docker.version
docker_var=$( cat /var/rdisco/docker.version )

if [ "$docker_var" == "18.03.1-ce," ]
then
  echo "50" | dialog --gauge "Docker Is Already Installed" 7 50 0
  sleep 1
else
  echo "50" | dialog --gauge "Installing: Docker 18.03 (Please Be Patient)" 7 58 0
  ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags docker 1>/dev/null 2>&1
fi

############################################################ Portainer Install
echo "79" | dialog --gauge "Installing: Portainer" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags portainer &>/dev/null &


echo "85" | dialog --gauge "Forcing Reboot of Existing Containers!" 7 50 0
bash /opt/rdisco/scripts/containers/reboot.sh &>/dev/null &

echo "88" | dialog --gauge "Installing: WatchTower" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags watchtower &>/dev/null &

echo "94" | dialog --gauge "Installing: Python Support" 7 50 0
bash /opt/rdisco/scripts/baseinstall/python.sh 1>/dev/null 2>&1

cat /var/rdisco/rdisco.preinstall > /var/rdisco/rdisco.preinstall.stored
clear