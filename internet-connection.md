# <center>Intro</center>

_After clean installation, you will have only comand-line version of Debian distro, with bare mimimum tools that allow you make connection to the Internet. I don`t now why, but in server version of installation do not included such needed tools as ifconfig, iwconfig, nmcli. All I investigate is ip, iw, wpa_supplicant. So I make my own instruction how to connect to wifi with all of this. In future I think I will ctreate instruction for wired connection, but this is not important for me now, so let see)_



## Instruction how to connect to wifi network using only ip, iw and wpa_supplicant
as we do not have sudo yet, all operations needed to be done as root user

1. Looking for available network interfaces
```
ip a
```
2. If wifi interface is down, we will wake it up(wlps0 is only for example, you need write your own interface name):
```
ip link set wlps0 up
```
3. Check the connection
```
/sbin/iw wlps0
```
4. If connection is established continue, else go to first step and check all your commands. In this step we scanning available wifi networks:
```
/sbin/iw wlps0 scan | grep SSID
```
5. Make connection config to wifi network:
```
wpa_passphrase <SSID> <password> | tee \etc\wpa_supplicant.conf
```
6. Make connection:
```
/sbin/wpa_supplicant -c /etc/wpa_supplicant.conf -i wlps0
```
7. Run DHCP client
```
/sbin/dhcpclient wlps0
```
8. Check connection:
```
ping 8.8.8.8
```
Voila! Now you must be connected to internet and continue installation process. If you has any trouble return to previous steps and check commands.
After all installation scripts done and you will have desktop environment, kill wpa_supplicant and configure network thru nmcli or any other way, 
you will have all tools needed for network configuration installed.
```
killall /sbin/wpa_supplicant
```
