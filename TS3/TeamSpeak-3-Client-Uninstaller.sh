#!/bin/bash

#
#
# Created by Razuuu
#
#
# Contact:
#   > Mail: joshua@arrow-systems.de
#   > TeamSpeak: ts.arrow-systems.de
#   > GitHub: Razuuu
#
#
# Copyright (c) 2020 Razuuu
#
#

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

clear
echo "Uninstall all TeamSpeak 3 Clients"
sleep 2
rm /opt/teamspeak/client/3/ -r
rm /usr/share/applications/ts3client-*
clear
echo "all TeamSpeak 3 Clients successfully uninstalled"
