#!/bin/bash

# Install pre-reqs via Bash

yum upgrade -y 1>/dev/null 2>&1
yum install epel-release -y 1>/dev/null 2>&1
yum install dialog git wget vim whiptail -y 1>/dev/null 2>&1

yum install ansible -y 1>/dev/null 2>&1

yum upgrade -y 1>/dev/null 2>&1

# Start calling ansible playbooks

