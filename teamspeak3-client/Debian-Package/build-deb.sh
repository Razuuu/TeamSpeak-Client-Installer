#!/bin/bash
# Created by Razuuu / www.razuuu.de

ts3version=$1

if [ -z "$ts3version" ]; then
  echo "Usage: $(basename "$0") ts3version"
  exit 1
fi

# Download logo
curl --progress-bar -O "https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png"

# Loop through architectures
for i in amd64 i386; do
  if [ "$i" == "i386" ]; then
    tarch="x86"
  else
    tarch="amd64"
  fi

  echo "Building Debian package for $i!"

  # Create directory structure
  build_dir="${ts3version}/${i}"
  mkdir -p "${build_dir}/opt/teamspeak3-client"
  cp -r DEBIAN "${build_dir}"
  cp -r usr "${build_dir}"

  # Replace placeholders in control files
  sed -i "s|ts3ver|${ts3version}|g" "${build_dir}/DEBIAN/control"
  sed -i "s|pcarch|${i}|g" "${build_dir}/DEBIAN/control"
  sed -i "s|ts3ver|${ts3version}|g" "${build_dir}/usr/share/applications/teamspeak3-client.desktop"

  # Download and bypass license
  installation_script="TeamSpeak3-Client-linux_${tarch}-${ts3version}.run"
  curl --progress-bar -O "https://files.teamspeak-services.com/releases/client/${ts3version}/${installation_script}"
  sed -i '/^MS_PrintLicense()/,/^}/{s/^/#/}' "${installation_script}"
  sed -i '/^ *if test $totalsize -ne `expr $fsize - $offset`; then$/,/^ *fi$/s/^/#/' "${installation_script}"

  # Install and copy files
  bash "${installation_script}" --target "${build_dir}/opt/teamspeak3-client"
  cp logo.png "${build_dir}/opt/teamspeak3-client"

  # Create Debian package
  dpkg-deb --build "${build_dir}" "teamspeak3-client_${ts3version}_${i}.deb"
  echo "Done building for $i!"
done

# Clean up
rm -rf "${ts3version}"
rm -f *.run
rm logo.png

clear
echo "Done building TeamSpeak 3 Client for amd64 and i386"
exit 0
