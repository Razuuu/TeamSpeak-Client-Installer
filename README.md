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

#### Using Debian Repository
```
sudo apt install teamspeak3-client
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
apt purge teamspeak-<3,5>-client
```
