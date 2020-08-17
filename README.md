# flyVPN-socks5

## 變更腳本執行權限
```bash
chmod -R 777 *.sh
```
## 安裝&設定
> 透過腳本安裝dante-server(proxy-server) 和 flyVPN，並且設定執行環境境。
> 請先修改腳本內定義變數，執行期間會建立proxyuser帳戶請將密碼記錄下來。
```bash
sudo ./install.sh
```
## 啟動flyVPN
> 請先修改VPN_NAME變數指定flyVPN所連向的主機
```bash
./start.sh
```

## 測試
> 請先修改PASSWORD變數，這邊是指安裝時候建建立proxyuser帳戶的密碼。
> 此腳本會連上socks5的proxy開啟[myip](https://myip.com.tw/)網站看目前拿到的IP
```bash
./test.sh
```
