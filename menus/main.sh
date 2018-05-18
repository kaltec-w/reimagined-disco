#!/bin/bash

# setup ncurses
export NCURSES_NO_UTF8_ACS=1
echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local

# folder for var files
mkdir /var/rdisco/ 1>/dev/null 2>&1

# Set Fixed Information
bash /opt/rdisco/scripts/info.sh

# verify dialog is installed
file="/usr/bin/dialog"
if [ -e "$file" ]
then
   clear 1>/dev/null 2>&1
else
   clear
   echo "Installing Dialog"
   apt-get install dialog 1>/dev/null 2>&1
   export NCURSES_NO_UTF8_ACS=1
   echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local
fi

# check rdisco.preinstall file
current=$( cat /var/rdisco/rdisco.preinstall ) 1>/dev/null 2>&1
stored=$( cat /var/rdisco/rdisco.preinstall.stored ) 1>/dev/null 2>&1
if [ "$current" == "$stored" ]
then
   touch /var/rdisco/message.no
else
   bash /opt/rdisco/scripts/baseinstall/main.sh
fi







clear
HEIGHT=16
WIDTH=38
CHOICE_HEIGHT=10
BACKTITLE="Kaltec"
TITLE="rDisco - LibreNMS"

OPTIONS=(A "Full Install"
         Z "Exit")

CHOICE=$(dialog --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
        A)
            bash /opt/rdisco/scripts/baseinstall/fullinstall.sh ;;
        Z)
            bash /opt/rdisco/scripts/messages/end.sh
            exit 0 ;;
esac
