#!/bin/bash
# Created by Razuuu / www.razuuu.de

ts3version=$1

if [ -z ${ts3version} ]; then
  echo "bash `basename $0` ts3version"
  exit 1
fi

# Download logo
curl --progress-bar -O https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/logo.png

# Build begins
for i in amd64 i386; do

if [ ${i} == i386 ]; then
tarch="x86"
else
tarch="amd64"
fi

echo "Build Debian package for ${i}!"

mkdir -p ${ts3version}/${i}
mkdir ${ts3version}/${i}/opt
cp -r DEBIAN ${ts3version}/${i}
cp -r usr ${ts3version}/${i}

sed -i 's|ts3ver|'"$ts3version"'|g' ${ts3version}/${i}/DEBIAN/control
sed -i 's|pcarch|'"$i"'|g' ${ts3version}/${i}/DEBIAN/control
sed -i 's|ts3ver|'"$ts3version"'|g' ${ts3version}/${i}/usr/share/applications/teamspeak3-client.desktop

curl --progress-bar -O https://files.teamspeak-services.com/releases/client/${ts3version}/TeamSpeak3-Client-linux_${tarch}-${ts3version}.run
bash TeamSpeak3-Client-linux_${tarch}-${ts3version}.run --target ${ts3version}/${i}/opt/teamspeak3-client
cp logo.png ${ts3version}/${i}/opt/teamspeak3-client

dpkg-deb --build ${ts3version}/${i} teamspeak3-client_${ts3version}_${i}.deb
echo "done"

done

# clean
rm -rf ${ts3version}
rm -f *.run
rm logo.png

clear
echo "Done building TeamSpeak 3 Client for amd64 and i386"

exit 0
