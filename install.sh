#!/bin/bash
DANTE_INTERNAL_HOST="eno1" #對內網卡/IP (must be use network name, will flyvpn can't mapping port)
DANTE_INTERNAL_PORT=1080        #對內port
DANTE_EXTERNAL_HOST="eno1"      #對外網卡/IP
FLYVPN_USERNAME=""              #flyVPN 帳號
FLYVPN_PASSWORD=""              #flyVPN 密碼

echo
echo "1. install dante proxy"
DANTE_PKG_NAME="dante-server"
if apt-get -qq install $DANTE_PKG_NAME; then
    echo "$DANTE_PKG_NAME already installed... "
else
    echo "$DANTE_PKG_NAME not install, and installing now..."
    apt-get install $DANTE_PKG_NAME | y
fi

echo
echo "1.5 create user 'proxyuser' for dante proxy"
if id -u "proxyuser" >/dev/null 2>&1; then
    echo "proxyuser user exists..."
else
    echo "proxyuser does not exist..."
    useradd -r -s /bin/false proxyuser
    passwd proxyuser
fi

echo
echo "2. config dante proxy"
echo "internal=$DANTE_INTERNAL_HOST, port=$DANTE_INTERNAL_PORT external=$DANTE_EXTERNAL_HOST"
cp sockd.conf /tmp/sockd.conf
systemctl stop danted
systemctl disable danted
sed -i /tmp/sockd.conf -e "s/{DANTE_INTERNAL_HOST}/$DANTE_INTERNAL_HOST/g" 
sed -i /tmp/sockd.conf -e "s/{DANTE_INTERNAL_PORT}/$DANTE_INTERNAL_PORT/g" 
sed -i /tmp/sockd.conf -e "s/{DANTE_EXTERNAL_HOST}/$DANTE_EXTERNAL_HOST/g" 
mv /tmp/sockd.conf /etc/danted.conf

echo
echo "3. start dante proxy"
systemctl start danted
DANTE_STATUS=($(systemctl status danted | grep "Active" | awk '{print$2}'))
echo "checking dante proxy status...$DANTE_STATUS"

echo
echo "4. downlaod & uncompress flyVPN"
FLYVPN_DOWN_PATH="/tmp/flyvpn.tar.gz"
wget https://www.flyvpn.com/files/downloads/linux/flyvpn-x86_64-4.0.7.0.tar.gz -O $FLYVPN_DOWN_PATH -q --show-progress 
tar zxvf $FLYVPN_DOWN_PATH -C /usr/bin/ #解壓縮
chmod -R 777 /usr/bin/flyvpn #變更執行權限
rm $FLYVPN_DOWN_PATH

echo
echo "5. config flyVPN"
rm /etc/flyvpn.conf
touch /etc/flyvpn.conf
echo "user $FLYVPN_USERNAME" >> /etc/flyvpn.conf
echo "pass $FLYVPN_PASSWORD" >> /etc/flyvpn.conf
