#!/bin/bash
# Created by Razuuu / www.razuuu.de

# Fetch the HTML content and store it in a variable
html_content=$(curl -s "https://teamspeak.com/en/downloads/")

# Search for version information starting with "5.0.0" in the HTML content
version_pattern="5\.0\.0.*"
if [[ "$html_content" =~ $version_pattern ]]; then
    tsversion=$(echo "$html_content" | grep -oP "$version_pattern" | head -1)
else
    echo "Version starting with 5.0.0 not found on the webpage. Please check it manually on $html_content!"
    exit 1
fi


# Clear the screen
clear

# Display script header
echo -e "Unofficial TeamSpeak Client Auto-Installer\nVersion: v2.0-STABLE\n"

# Check if another TeamSpeak installation exists
if [ -d "/opt/teamspeak-client" ]; then
    read -p "Another TeamSpeak installation already exists. Do you want to continue? (Y/n): " choice
    if [[ ! "$choice" =~ ^[Yy]$ ]]; then
        echo "Exiting script."
        exit 1
    else
        echo -e "Removing existing installation...\n"
        rm -rf "/opt/teamspeak-client"
        rm -f "/usr/share/applications/teamspeak-client.desktop"
    fi
fi

# Create TeamSpeak config directory for all users
for user_dir in /home/*; do
    if [ -f "$user_dir/.bashrc" ]; then
        mkdir -p "$user_dir/.config/TeamSpeak/Default"
    fi
done

# Download and install TeamSpeak client
echo -e "Downloading TeamSpeak client version $tsversion...\n"
install_dir="/opt/teamspeak-client"
mkdir -p "$install_dir"
cd "$install_dir"
curl --progress-bar -O "https://files.teamspeak-services.com/pre_releases/client/$tsversion/teamspeak-client.tar.gz"

echo -e "\nExtracting TeamSpeak client archive...\n"
tar -xvzf "teamspeak-client.tar.gz"

# Create desktop entry for TeamSpeak client
echo -e "Creating desktop entry...\n"
desktop_entry="[Desktop Entry]
Name=Teamspeak Client
Version=$tsversion
GenericName=TeamSpeak5
Comment=TeamSpeak Voice Communication Client
Exec=$install_dir/TeamSpeak
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=$install_dir/logo-256.png
Categories=Audio;Chat;Network;
StartupWMClass=TeamSpeak
StartupNotify=false
MimeType=x-scheme-handler/ts3server;x-scheme-handler/teamspeak;"
echo "$desktop_entry" > "teamspeak-client.desktop"

# Move desktop entry to applications directory
echo -e "Moving desktop entry to /usr/share/applications...\n"
mv "teamspeak-client.desktop" "/usr/share/applications"

# Set appropriate permissions
echo -e "Setting permissions...\n"
chmod -R 755 "$install_dir"

# Display installation completion message
echo -e "TeamSpeak Client Version $tsversion successfully installed at location: $install_dir\n"
echo "Thank you for using this Installer!"
exit 0
