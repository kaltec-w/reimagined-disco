#!/bin/bash


############################################################ Basic Menu
if dialog --stdout --title "rDisco Install" \
  --backtitle "kaltec" \
  --yesno "\nWould you like to install LibreNMS and MariaDB?" 7 50; then
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


############################################################ Container Installs
echo "72" | dialog --gauge "Installing: mariadb" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags mariadb &>/dev/null &
sleep 5

echo "72" | dialog --gauge "Installing: LibreNMS" 7 50 0
ansible-playbook /opt/rdisco/ansible/rdisco.yml --tags librenms &>/dev/null &
sleep 5

echo "80" | dialog --gauge "Forcing Reboot of Existing Containers!" 7 50 0
bash /opt/rdisco/scripts/containers/reboot.sh &>/dev/null &
sleep 5

echo "100" | dialog --gauge "Installation Complete!" 7 50 0
sleep 5
