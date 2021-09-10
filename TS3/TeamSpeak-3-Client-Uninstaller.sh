#!/bin/bash
# Created by Razuuu / www.razuuu.de

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

clear
echo "Uninstall TeamSpeak 3 Client"
sleep 2

rm -rf /opt/teamspeak3-client
rm -f /usr/share/applications/teamspeak3-client.desktop

echo "TeamSpeak 3 Client successfully uninstalled!"
exit 0
