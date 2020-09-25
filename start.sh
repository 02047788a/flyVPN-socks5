#!/bin/bash

VPN_NAME="3533-jp-Tokyo"
USNERNAME="proxyuser"
PASSWORD="88958895"
company_ip="114.34.170.104"
current_ip=$(curl -s -v -x socks5://$USNERNAME:$PASSWORD@127.0.0.1:1080 ifconfig.me)
danted_status=$(systemctl status danted.service | grep "Active:" | awk '{print $2}')
#echo "company_ip=$company_ip"
#echo "current_ip=$current_ip"


if [ "$danted_status" != "active" ];then
        systemctl start danted.service
fi

echo "current_ip=$current_ip"
if [ -z "$current_ip" ] ||  ["$current_ip" == "$company_ip" ]; then
        killall flyvpn
        echo "not use flyVPN. (current_ip=$current_ip)"
        flyvpn login
        echo "socks5" | flyvpn connect "$VPN_NAME"
else
        echo "useing flyVPN connect to $VPN_NAME. (current_ip=$current_ip)"
fi
