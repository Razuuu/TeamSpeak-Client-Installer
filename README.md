# TeamSpeak-Client-Installer
Unofficial TeamSpeak 3 & "5" Client Installer
for Debian and Debian-based Distributions.  
  
This script must be run as root or sudo

## Dependencies
- curl

##  TeamSpeak 3 Client

#### Using script
```
curl -O -s https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/teamspeak3-client/install.sh
bash install.sh
```

#### Using [Debian Repository](https://deb.razuuu.de/debian)
```
sudo apt install teamspeak3-client
```

#### Using [Debian Package](https://github.com/Razuuu/TeamSpeak-Client-Installer/releases)
```
sudo apt install ./teamspeak3-client_3.5.6_amd64.deb
sudo apt install ./teamspeak3-client_3.5.6_i386.deb
```

#### Using dpkg
```
sudo dpkg -i ./teamspeak3-client_3.5.6_amd64.deb
sudo dpkg -i ./teamspeak3-client_3.5.6_i386.deb
```
## TeamSpeak Client
#### Using script
```
curl -O -s https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/teamspeak-client/install.sh
bash install.sh
```

## Uninstall
For uninstalling the TeamSpeak Client using script, do
```
bash uninstall.sh <3, 5>
```
By using Debian Repository use apt instead
```
apt purge teamspeak<3,5>-client
```
