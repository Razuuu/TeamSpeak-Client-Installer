#!/bin/bash
# Created by Razuuu / www.razuuu.de

# Check architecture
case $(dpkg --print-architecture) in
  amd64*) tarch="amd64";;
   i386*) tarch="x86";;
       *) echo "Your architecture is not supported by TeamSpeak!"; exit 1;;
esac

# Clear the screen
clear

# Display script header
echo -e "Unofficial TeamSpeak 3 Client Auto-Installer\nVersion: v2.0-STABLE\n"

# Check if another TS3 installation exists
if [ -d "/opt/teamspeak3-client" ]; then
    read -p "Another TS3 installation already exists. Do you want to continue? (Y/n): " choice
    if [[ ! "$choice" =~ ^[Yy]$ ]]; then
        echo "Exiting script."
        exit 1
    else
        echo -e "Removing existing installation...\n"
        rm -rf "/opt/teamspeak3-client"
        rm -f "/usr/share/applications/teamspeak3-client.desktop"
    fi
fi

# Read the desired TeamSpeak 3 version
read -p "Enter the TeamSpeak 3 Version you want to install: " ts3version

# Check if version input is empty
if [ -z "$ts3version" ]; then
    echo "Input is empty!"
    exit 1
fi

# Create temporary directory
tmp_dir="/var/tmp/razuuu-github-$(basename "$0")"
mkdir -p "$tmp_dir"
cd "$tmp_dir"

installation_script="TeamSpeak3-Client-linux_${tarch}-${ts3version}.run"

# Download TeamSpeak 3 client
echo -e "Downloading TeamSpeak 3 client version $ts3version...\n"
curl --progress-bar -O "https://files.teamspeak-services.com/releases/client/${ts3version}/${installation_script}"

# Bypass license
sed -i '/^MS_PrintLicense()/,/^}/{s/^/#/}' "${installation_script}"
sed -i '/^ *if test $totalsize -ne `expr $fsize - $offset`; then$/,/^ *fi$/s/^/#/' "${installation_script}"

# Run the installation script
echo -e "\nRunning installation script...\n"
chmod +x "${installation_script}"
"./${installation_script}" --target "/opt/teamspeak3-client"

# Create desktop entry
desktop_entry="[Desktop Entry]
Name=Teamspeak 3 Client
Version=$ts3version
GenericName=TeamSpeak3
Comment=Speak with friends
Exec=/opt/teamspeak3-client/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak3-client/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3
StartupNotify=true"
echo "$desktop_entry" > "teamspeak3-client.desktop"

# Download and place logo
echo -e "Downloading logo...\n"
curl --progress-bar -o "/opt/teamspeak3-client/logo.png" "https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png"

# Move desktop entry to applications directory
echo -e "Moving desktop entry to /usr/share/applications...\n"
mv "teamspeak3-client.desktop" "/usr/share/applications"

# Set appropriate permissions
echo -e "Setting permissions...\n"
chmod -R 755 "/opt/teamspeak3-client"

# Cleanup
echo -e "Cleaning up...\n"
cd ~
rm -rf "$tmp_dir"

# Display installation completion message
echo -e "TeamSpeak 3 Client Version $ts3version successfully installed at location: /opt/teamspeak3-client\n"
echo "Thank you for using this Installer!"
exit 0
