USNERNAME="proxyuser"
PASSWORD=""
current_ip=$(curl -v -x socks5://$USNERNAME:$PASSWORD@127.0.0.1:1080 ifconfig.me)

if [ -z "$current_ip" ]; then
    echo "Not connect flyVPN. (company ip: $company_ip)"
else
    echo "Current is $current_ip connecting flyVPN. (company ip: $company_ip)"
fi