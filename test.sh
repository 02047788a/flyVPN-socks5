USNERNAME="proxyuser"
PASSWORD=""

curl -v -x socks5://$USNERNAME:$PASSWORD@127.0.0.1:1080 https://myip.com.tw/