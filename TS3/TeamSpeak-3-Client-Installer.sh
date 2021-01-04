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

INSTALLER_VERSION="1.8-STABLE" # installer version
STABLE_TS3CLIENT_VERSION="3.5.6 (2021.01.04)" # stable ts3 version
TS3CLIENT_VERSION=$1 # arg1
TS3CLIENT_LOGO="https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png" # download logo
ARCHITECTURE=$(dpkg --print-architecture) # architecture

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

if [ -z $TS3CLIENT_VERSION ]; then
   echo "bash `basename $0` <TS3Client-Version>"
   echo "$STABLE_TS3CLIENT_VERSION"
   exit 1
fi

# AMD64 START
amd64() {

        start_real

	# Download file | amd64
	echo "Download file TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run"
	sleep 3
	curl -O -s https://files.teamspeak-services.com/releases/client/$TS3CLIENT_VERSION/TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Give file execute rights and run | amd64
	echo "Give file execute rights..."
	sleep 3
	chmod +x TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Run file | amd64
	echo "Run file, please follow instructions!"
	sleep 3
	bash TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Create ts3client-<ts3client_version>-amd64.desktop and write text inside | amd64
	echo "Create ts3client-$TS3CLIENT_VERSION-amd64.desktop"
	touch ts3client-$TS3CLIENT_VERSION-amd64.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client - $TS3CLIENT_VERSION (amd64)
VERSION=$TS3CLIENT_VERSION
GenericName=TeamSpeak3 $TS3CLIENT_VERSION amd64
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3 $TS3CLIENT_VERSION (amd64)
StartupNotify=true" > ts3client-$TS3CLIENT_VERSION-amd64.desktop

	sleep2_clear

	download_logo

	sleep2_clear

	# Copy files to /opt/teamspeak/client/3/amd64/<ts3client_version>/ and /usr/share/applications/ts3client-<ts3client_version>-amd64.desktop | amd64
	echo "Move TeamSpeak3-Client-linux_amd64 to /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/"
	echo "and ts3client-$TS3CLIENT_VERSION-amd64.desktop to /usr/share/applications/ts3client-$TS3CLIENT_VERSION-amd64.desktop"
	sleep 3

	if_things

	# if start | amd64
	if [ ! -d /opt/teamspeak/client/3/amd64/ ]; then
		mkdir -p /opt/teamspeak/client/3/amd64/
	fi

	if [ ! -d /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/ ]; then
		mkdir -p /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/
	fi
	# if stop | amd64

	mkdir -p temp_$TS3CLIENT_VERSION
	mv TeamSpeak3-Client-linux_amd64/* temp_$TS3CLIENT_VERSION/
	
	mv temp_$TS3CLIENT_VERSION/* /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/
	mv ts3client-$TS3CLIENT_VERSION-amd64.desktop /usr/share/applications/ts3client-$TS3CLIENT_VERSION-amd64.desktop

	sleep2_clear

	# Give folder full rights | amd64
	echo "Give folder 777 rights to execute it from a non-root-user"
	sleep 3
	chmod -R 777 /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/

	sleep2_clear

	delete_temporary_folder

	echo "TeamSpeak 3 Client Version $TS3CLIENT_VERSION successfully"
	echo "installed at location: /opt/teamspeak/client/3/amd64/$TS3CLIENT_VERSION/"

	end
}
# AMD64 STOP

# I386 START
i386() {

        start_real

	# Download file | i386
	echo "Download file TeamSpeak3-Client-linux_x86-$TS3CLIENT_VERSION.run"
	sleep 3
	curl -O -s https://files.teamspeak-services.com/releases/client/$TS3CLIENT_VERSION/TeamSpeak3-Client-linux_x86-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Give file execute rights and run | i386
	echo "Give File execute rights..."
	sleep 3
	chmod +x TeamSpeak3-Client-linux_x86-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Run file | i386
	echo "Run file, please follow instructions!"
	sleep 3
	bash TeamSpeak3-Client-linux_x86-$TS3CLIENT_VERSION.run

	sleep2_clear

	# Create ts3client-<ts3client_version>-i386.desktop and write text inside | i386
	echo "Create ts3client-$TS3CLIENT_VERSION-i386.desktop"
	touch ts3client-$TS3CLIENT_VERSION-i386.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client - $TS3CLIENT_VERSION (i386)
VERSION=$TS3CLIENT_VERSION
GenericName=TeamSpeak3 $TS3CLIENT_VERSION i386
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3 $TS3CLIENT_VERSION (i386)
StartupNotify=true" > ts3client-$TS3CLIENT_VERSION-i386.desktop

	sleep2_clear

	download_logo

	sleep2_clear

	# Copy files to /opt/teamspeak/client/3/i386/<ts3client_version>/ and /usr/share/applications/ts3client-<ts3client_version>-i386.desktop | i386
	echo "Move TeamSpeak3-Client-linux_x86 to /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/"
	echo "and ts3client-$TS3CLIENT_VERSION-i386.desktop to /usr/share/applications/ts3client-$TS3CLIENT_VERSION-i386.desktop"
	sleep 3

	if_things

	# if start | i386
	if [ ! -d /opt/teamspeak/client/3/i386/ ]; then
		mkdir -p /opt/teamspeak/client/3/i386/
	fi

	if [ ! -d /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/ ]; then
		mkdir -p /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/
	fi
	# if stop | i386

	mkdir -p temp_$TS3CLIENT_VERSION
	mv TeamSpeak3-Client-linux_x86/* temp_$TS3CLIENT_VERSION/
	
	mv temp_$TS3CLIENT_VERSION/* /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/
	mv ts3client-$TS3CLIENT_VERSION-i386.desktop /usr/share/applications/ts3client-$TS3CLIENT_VERSION-i386.desktop

	sleep2_clear

	# Give folder full rights | i386
	echo "Give folder 777 rights to execute it from a non-root-user"
	sleep 3
	chmod -R 777 /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/

	sleep2_clear

	delete_temporary_folder

	echo "TeamSpeak 3 Client Version $TS3CLIENT_VERSION successfully"
	echo "installed at location: /opt/teamspeak/client/3/i386/$TS3CLIENT_VERSION/"

	end
}
# I386 STOP

start_real() {
clear

	start_text

	sleep2_clear
	
        create_temporary_folder

        sleep2_clear
}

start_text() {
echo "Unofficial TeamSpeak 3 Client Auto-Installer"
sleep 0.4
echo "Version: v$INSTALLER_VERSION"
sleep 3
clear
}

sleep2_clear() {
	sleep 2
	clear
}

download_logo() {
	# Download logo | amd64
	echo "Download logo and move it to TeamSpeak3-Client-linux_amd64..."
	sleep 3
	cd TeamSpeak3-Client-linux_amd64
	curl -O -s $TS3CLIENT_LOGO
	cd ..
}

create_temporary_folder() {
	# Create temporary Folder and go inside
	echo "Create temporary folder for this script and go to the folder..."
	sleep 3
	mkdir -p /var/tmp/teamspeak-3-client-installer/
	cd /var/tmp/teamspeak-client-installer/
}

if_things() {
	if [ -f /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop ]; then
		rm /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop
	fi

	if [ ! -d /opt/teamspeak/ ]; then
		mkdir -p /opt/teamspeak/
	fi
	
	if [ ! -d /opt/teamspeak/client/ ]; then
		mkdir -p /opt/teamspeak/client/
	fi
	
	if [ ! -d /opt/teamspeak/client/3/ ]; then
		mkdir -p /opt/teamspeak/client/3/
	fi
}

delete_temporary_folder() {
	# Go to /home and delete temporary folder
	echo "Delete temporary folder..."
	cd /home
	rm -rf /var/tmp/teamspeak-client-installer/
}

end() {
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

exit 0
}

if [ $ARCHITECTURE = "amd64" ]; then

	amd64

			elif [ $ARCHITECTURE == "i386" ]; then

				i386

					else

						echo "Your architecture are not supported by TeamSpeak"
						echo
						echo "Supported architectures:"
						echo "> amd64"
						echo "> i386"
fi
