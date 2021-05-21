#!/bin/bash

VPN_NAME="Taipei #71"
ddd=$(ps aux | grep "[f]lyvpn connect")
myip=$(curl -x http://127.0.0.1:1080 -L ifconfig.me/ip)
comip="114.34.170.104"

if [ -z $myip ]
then
	echo "asdasd"
       myip="$comip"
fi 

if [ $myip == $comip ] 
then
        killall flyvpn
        echo "not use flyVPN. (ip=$myip)"
        flyvpn login
        echo "proxy" | flyvpn connect "$VPN_NAME"
else
        echo "useing flyVPN connect to $VPN_NAME. (ip=$myip)"
fi
