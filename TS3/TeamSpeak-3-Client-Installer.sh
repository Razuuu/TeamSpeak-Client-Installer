#!/bin/bash
# Created by Razuuu / www.razuuu.de

# Functions and variables
arch=$(dpkg --print-architecture)

function text_sleep() {
  sleep 2
  clear
  echo -e "${@}"
  sleep 3
}

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

echo "What for TeamSpeak 3 Version do you want to install?"
read -p " » " ts3version

if [ -z ${ts3version} ]; then
  echo "Input is empty!"
  exit 1
fi

text_sleep "Unofficial TeamSpeak 3 Client Auto-Installer\nVersion: v1.9-STABLE"

text_sleep "Create temporary folder for this script"
mkdir -p /var/tmp/razuuu-github-`basename $0`
cd /var/tmp/razuuu-github-`basename $0`

text_sleep "Download file TeamSpeak3-Client-linux_${tarch}-${ts3version}.run"
curl -O -s https://files.teamspeak-services.com/releases/client/${ts3version}/TeamSpeak3-Client-linux_${tarch}-${ts3version}.run

text_sleep "Run file, please follow instructions!"
chmod +x TeamSpeak3-Client-linux_${tarch}-${ts3version}.run
bash TeamSpeak3-Client-linux_${tarch}-${ts3version}.run

text_sleep "Create ts3client-${ts3version}-${arch}.desktop"
touch ts3client-${ts3version}-${arch}.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client - ${ts3version} (${arch})
VERSION=${ts3version}
GenericName=TeamSpeak3 ${ts3version} ${arch}
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/client/3/${arch}/${ts3version}/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/client/3/${arch}/${ts3version}/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3 ${ts3version} (${arch})
StartupNotify=true" > ts3client-${ts3version}-${arch}.desktop

text_sleep "Download logo and move it to TeamSpeak3-Client-linux_${tarch}..."
cd TeamSpeak3-Client-linux_${tarch}
curl -O -s https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png
cd ..

text_sleep "Move TeamSpeak3-Client-linux_${tarch} to /opt/teamspeak/client/3/${arch}/${ts3version}/\n
and ts3client-${ts3version}-${arch}.desktop to /usr/share/applications/ts3client-${ts3version}-${arch}.desktop"

if [ -f /usr/share/applications/ts3client-${ts3version}-${arch}.desktop ]; then
  rm /usr/share/applications/ts3client-${ts3version}-${arch}.desktop
fi

# Move TS3 to /opt
mkdir -p /opt/teamspeak/client/3/${arch}
mv TeamSpeak3-Client-linux_${tarch} /opt/teamspeak/client/3/${arch}/${ts3version}
mv ts3client-${tarch}-${ts3version}.desktop /usr/share/applications/ts3client-${tarch}-${ts3version}.desktop
chmod -R 777 /opt/teamspeak/client/3/${arch}/${tarch}/

text_sleep "Delete temporary folder..."
cd ~
rm -rf /var/tmp/razuuu-github-`basename $0`

clear
echo "
TeamSpeak 3 Client Version ${ts3version} (${arch}) successfully
installed at location: /opt/teamspeak/client/3/${arch}/${ts3version}/

Following Websites used:
files.teamspeak-services.com, github.com, raw.githubusercontent.com

Script by Razuuu (https://www.github.com/Razuuu)
Thank you for using this Installer!
"

exit 0
