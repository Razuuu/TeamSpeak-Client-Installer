#!/bin/bash
# Created by Razuuu / www.razuuu.de

# Functions and variables
arch=$(dpkg --print-architecture)

# Check root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

# Check and set architecture
case ${arch} in
  amd64*) tarch="amd64";;
   i386*) tarch="x86";;
       *) echo "Your architecture are not supported by TeamSpeak!"; exit 0;;
esac

clear
echo -e "Unofficial TeamSpeak 3 Client Auto-Installer\nVersion: v2.0-STABLE\n"

if [ -d /opt/teamspeak3-client ]; then
	echo "Another TS3 installation already exists, do you want to continue?"
	echo "(Y)es | (N)o"
	while true; do
		read -p " » " select
		case $select in
			[Yy]*) echo -e "Okay, continue!\n"; \
			rm -rf /opt/teamspeak3-client >/dev/null; \
			rm -f /usr/share/applications/teamspeak3-client.desktop; break;;
			[Nn]*) echo "Exit script!"; exit 1;;
			    *) echo "No option selected!";;
		esac
	done
fi

echo -e "What for TeamSpeak 3 Version do you want to install?"
read -p " » " ts3version

if [ -z ${ts3version} ]; then
  echo "Input is empty!"
  exit 1
fi

echo -e "\nCreate temporary folder for this script\n"
mkdir -p /var/tmp/razuuu-github-`basename $0`
cd /var/tmp/razuuu-github-`basename $0`

echo -e "Download file TeamSpeak3-Client-linux_${tarch}-${ts3version}.run, please wait\n"
curl --progress-bar -O https://files.teamspeak-services.com/releases/client/${ts3version}/TeamSpeak3-Client-linux_${tarch}-${ts3version}.run

echo -e "\nRun file, please follow instructions!\n"
chmod +x TeamSpeak3-Client-linux_${tarch}-${ts3version}.run
bash TeamSpeak3-Client-linux_${tarch}-${ts3version}.run --target /opt/teamspeak3-client

echo -e "\nCreate teamspeak3-client.desktop\n"
touch teamspeak3-client.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client
VERSION=${ts3version}
GenericName=TeamSpeak3
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak3-client/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak3-client/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3
StartupNotify=true" > teamspeak3-client.desktop

echo -e "Download logo...\n"
cd /opt/teamspeak3-client
curl --progress-bar -O https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png

echo -e "\nMove teamspeak3-client.desktop to /usr/share/applications\n"
mv /var/tmp/razuuu-github-`basename $0`/teamspeak3-client.desktop /usr/share/applications
chmod -R 777 /opt/teamspeak3-client

echo -e "Delete temporary folder"
cd ~
rm -rf /var/tmp/razuuu-github-`basename $0`

echo "
TeamSpeak 3 Client Version ${ts3version} successfully
installed at location: /opt/teamspeak3-client

Following Websites used:
files.teamspeak-services.com, github.com, raw.githubusercontent.com

Script by Razuuu (https://www.github.com/Razuuu)
Thank you for using this Installer!
"
exit 0
