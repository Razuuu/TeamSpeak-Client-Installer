# TeamSpeak-Client-Installer
Unofficial TeamSpeak 3 & 5 Client Installer
for Debian and Debian-based Distributions.

## Dependencies
- curl

##  TeamSpeak 3 Client

#### Using script
```
curl -O -s https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/TS3/TeamSpeak-3-Client-Installer.sh
bash TeamSpeak-3-Client-Installer.sh
```

#### Using [Debian Repository](https://deb.razuuu.de/debian)
```
sudo apt install teamspeak3-client
```

#### Using [Debian Package](https://github.com/Razuuu/TeamSpeak-Client-Installer/releases)
```
sudo apt install ./teamspeak3-client_3.5.6_amd64.deb
```

#### Using dpkg
```
sudo dpkg -i ./teamspeak3-client_3.5.6_amd64.deb
```
## TeamSpeak 5 Client
#### Using script
```
curl -O -s https://raw.githubusercontent.com/Razuuu/TeamSpeak-Client-Installer/master/TS5/TeamSpeak-5-Client-Installer.sh
bash TeamSpeak-5-Client-Installer.sh
```

## Uninstall
For uninstalling the TeamSpeak Client using script, do
```
bash TeamSpeak-<3,5>-Client-Uninstaller.sh
```
By using Debian Repository use apt instead
```
apt purge teamspeak<3,5>-client
```
