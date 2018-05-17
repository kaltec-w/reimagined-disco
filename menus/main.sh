#!/bin/bash


export NCURSES_NO_UTF8_ACS=1
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
            bash /opt/plexguide/menus/donate/main.sh ;;
        Z)
            bash /opt/plexguide/scripts/message/ending.sh
            exit 0 ;;
esac

## repeat menu when exiting
bash /opt/plexguide/menus/main.sh
