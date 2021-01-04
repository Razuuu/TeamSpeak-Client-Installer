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
	echo "Uninstall TeamSpeak 5 Client"
	sleep 2
	rm /opt/teamspeak/client/5/ -r
	rm /usr/share/applications/ts5client*

clear
	echo "TeamSpeak 5 Client successfully uninstalled"
