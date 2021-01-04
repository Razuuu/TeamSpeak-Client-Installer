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

INSTALLER_VERSION="1.0-STABLE" # installer version
STABLE_TS5CLIENT_VERSION="5.0.0-beta36.1 (2021.01.04)" # stable ts5 version
TS5CLIENT_LOGO="https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png" # download logo
ARCHITECTURE=$(dpkg --print-architecture) # architecture

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

sleep2_clear() {
	sleep 2
	clear
}


if [ $ARCHITECTURE = "amd64" ]; then
	clear

	# start
	echo "Unofficial TeamSpeak 5 Client Auto-Installer"
	sleep 0.4
	echo "Version: v$INSTALLER_VERSION"
	sleep 3
	clear
	
	# Create Config folder
	echo "I need your current username to install TeamSpeak 5 Client on your PC"
	echo
	read -p "Username > " currentuser
	
	if [ ! -d /home/$currentuser/ ]; then
		clear
		echo "This user does not exist, exit script!"
		exit 0
	fi
	
	if [ ! -d /home/$currentuser/.config/TeamSpeak/Default ]; then
		mkdir -p /home/$currentuser/.config/TeamSpeak/Default
	fi

	sleep2_clear

	# Create temporary Folder and go inside
	echo "Create temporary folder for this script and go to the folder..."
	sleep 3
	mkdir -p /var/tmp/teamspeak-client-installer/
	cd /var/tmp/teamspeak-client-installer/

	sleep2_clear

	# Download & Extract file
	echo "Download & Extract file teamspeak-client.tar.gz"
	sleep 3
	mkdir -p ts5client
	cd ts5client
	curl -O -s https://files.teamspeak-services.com/teamspeak/teamspeak-client.tar.gz
	tar -xvzf t*
	rm teamspeak-client.tar.gz

	sleep2_clear

	# Create ts5client.desktop and write text inside
	echo "Create ts5client.desktop"

echo "[Desktop Entry]
Name=Teamspeak 5 Client
VERSION=5.0.0-beta36.1
GenericName=TeamSpeak5 5.0.0-beta36.1
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/client/5/ts5client/TeamSpeak
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/client/5/ts5client/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 5 5.0.0-beta36.1
StartupNotify=true" > ../ts5client.desktop

	sleep2_clear

	# Download logo
	echo "Download logo..."
	sleep 3
	curl -s -O $TS5CLIENT_LOGO

	sleep2_clear

	# Copy files to /opt/teamspeak/client/5/ts5client/ and /usr/share/applications/ts5client.desktop
	echo "Move ts5client to /opt/teamspeak/client/5/ts5client/"
	echo "and ts5client.desktop to /usr/share/applications/ts5client.desktop"
	sleep 3

	# If
	if [ -f /usr/share/applications/ts5client.desktop ]; then
		rm /usr/share/applications/ts5client.desktop
	fi

	if [ ! -d /opt/teamspeak/ ]; then
		mkdir -p /opt/teamspeak/
	fi

	if [ ! -d /opt/teamspeak/client/ ]; then
		mkdir -p /opt/teamspeak/client/
	fi

	if [ ! -d /opt/teamspeak/client/5/ ]; then
		mkdir -p /opt/teamspeak/client/5/
	fi

	cd ..
	mv ts5client /opt/teamspeak/client/5/
	mv ts5client.desktop /usr/share/applications/ts5client.desktop

	sleep2_clear

	# Give folder full rights | amd64
	echo "Give folder 777 rights to execute it from a non-root-user"
	sleep 3
	chmod -R 777 /opt/teamspeak/client/5/ts5client/

	sleep2_clear

	# delete temp folder
	echo "Delete temporary folder..."
	rm -rf /var/tmp/teamspeak-client-installer/

	echo "TeamSpeak 5 Client Version $STABLE_TS5CLIENT_VERSION successfully"
	echo "installed at location: /opt/teamspeak/client/5/ts5client/"

	clear

	sleep 2

	echo
	echo "Following Websites using:"
	echo "files.teamspeak-services.com, github.com, raw.githubusercontent.com"
	echo
	sleep 2

	echo "Script by Razuuu (https://www.github.com/Razuuu)"
	echo "Thank you for using this Installer! (v$INSTALLER_VERSION)"
	echo

		else

			echo "Your architecture are not supported by TeamSpeak"
			echo
			echo "Supported architecture: amd64"
fi

exit 0
