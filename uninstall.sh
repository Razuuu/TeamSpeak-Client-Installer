#!/bin/bash
# Created by Razuuu / www.razuuu.de

if [ -z $1 ]; then
   echo "bash `basename $0` <3,5>"
   exit 0
fi

case $1 in
   3) rm -rf /opt/teamspeak3-client; rm -f /usr/share/applications/teamspeak3-client.desktop ;;
   5) rm -rf /opt/teamspeak-client; rm -f /usr/share/applications/teamspeak-client.desktop ;;
   *) echo "Only 3 or 5 works!"
esac

echo "TeamSpeak $1 Client successfully uninstalled!"
exit 0
