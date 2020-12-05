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
echo "Uninstall TeamSpeak 3 Clients"
rm /opt/teamspeak/client/ -r
rm /usr/share/applications/ts3client-*
sleep 2
clear
echo "all clients uninstalled"
