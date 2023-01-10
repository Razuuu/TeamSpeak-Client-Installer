#!/bin/bash
# Created by Razuuu / www.razuuu.de

# Functions and variables
tsversion="5.0.0-beta70"
arch=$(dpkg --print-architecture)

clear
echo -e "Unofficial TeamSpeak Client Auto-Installer\nVersion: v2.0-STABLE\n"

if [ -d /opt/teamspeak-client ]; then
	echo "Another TeamSpeak installation already exists, do you want to continue?"
	echo "(Y)es | (N)o"
	while true; do
		read -e -p " » " -i "y" select
		case $select in
			[Yy]*) echo -e "Okay, continue!\n"; \
			rm -rf /opt/teamspeak-client >/dev/null; \
			rm -f /usr/share/applications/teamspeak-client.desktop; break;;
			[Nn]*) echo "Exit script!"; exit 1;;
			    *) echo "No option selected!";;
		esac
	done
fi

for USER in $(ls /home); do
	# Create TeamSpeak config file
	if [ -f /home/${USER}/.bashrc ]; then
		mkdir -p /home/${USER}/.config/TeamSpeak/Default
	fi
done

echo -e "Download file teamspeak-client.tar.gz, please wait\n"
mkdir -p /opt/teamspeak-client
cd /opt/teamspeak-client
curl --progress-bar -O https://files.teamspeak-services.com/pre_releases/client/$tsversion/teamspeak-client.tar.gz

echo -e "\nExtract file teamspeak-client.tar.gz!\n"
tar -xvzf teamspeak-client.tar.gz

echo -e "\nCreate teamspeak-client.desktop\n"
echo "[Desktop Entry]
Name=Teamspeak Client
Version=${tsversion}
GenericName=TeamSpeak5
Comment=TeamSpeak Voice Communication Client
Exec=/opt/teamspeak-client/TeamSpeak
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak-client/logo-256.png
Categories=Audio;Chat;Network;
StartupWMClass=TeamSpeak
StartupNotify=false
MimeType=x-scheme-handler/ts3server;x-scheme-handler/teamspeak;" > teamspeak-client.desktop

echo -e "\nMove teamspeak-client.desktop to /usr/share/applications\n"
mv teamspeak-client.desktop /usr/share/applications
chmod -R 777 /opt/teamspeak-client

echo "
TeamSpeak Client Version ${tsversion} successfully
installed at location: /opt/teamspeak5-client

Following Websites used:
files.teamspeak-services.com

Script by Razuuu (https://www.github.com/Razuuu)
Thank you for using this Installer!
"
exit 0
