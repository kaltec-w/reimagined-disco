#!/bin/sh
#
clear
figlet -f slant $(hostnamectl --pretty)
printf "\n"
printf "\t- %s\n\t- Kernel %s\n" "$(cat /etc/redhat-release)" "$(uname -r)"
printf "\n"



date=`date`
load=`cat /proc/loadavg | awk '{print $1}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}'`
memory_usage=`free -m | awk '/Mem:/ { total=$2 } /buffers\/cache/ { used=$3 } END { printf("%3.1f%%", used/total*100)}'`
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", "exit !$2;$3/$2*100") }'`
users=`users | wc -w`
time=`uptime | grep -ohe 'up .*' | sed 's/,/\ hours/g' | awk '{ printf $2" "$3 }'`
processes=`ps aux | wc -l`
ethup=$(ip -4 ad | grep 'state UP' | awk -F ":" '!/^[0-9]*: ?lo/ {print $2}')
ip=$(ip ad show dev $ethup |grep -v inet6 | grep inet|awk '{print $2}')

echo "System information as of: $date"
echo
printf "System load:\t%s\tIP Address:\t%s\n" $load $ip
printf "Memory usage:\t%s\tSystem uptime:\t%s\n" $memory_usage "$time"
printf "Usage on /:\t%s\tSwap usage:\t%s\n" $root_usage $swap_usage
printf "Local Users:\t%s\tProcesses:\t%s\n" $users $processes
echo

[ -f /etc/motd.tail ] && cat /etc/motd.tail || true