#!/bin/bash

VPN_NAME="Japan 41"
USNERNAME="proxyuser"
PASSWORD="88958895"
current_ip=$(curl  -s -v -x socks5://$USNERNAME:$PASSWORD@127.0.0.1:1080 ifconfig.me)

if [ -z "$current_ip" ]; then
    killall flyvpn
    echo "not use flyVPN. (current_ip=$current_ip)"
    flyvpn login
    echo "socks5" | flyvpn connect "$VPN_NAME"
else
    echo "useing flyVPN connect to $VPN_NAME. (current_ip=$current_ip)"
fi