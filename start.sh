#!/bin/bash

VPN_NAME="Thailand 02"
flyvpn login
echo "socks5" | flyvpn connect "$VPN_NAME"