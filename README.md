# ipchanger
Script to change IPv4 address permanently and quickly on Debian and RedHat.

Installation
-
```
git clone https://github.com/JackScripter/ipchanger.git
cd ipchanger
sudo chmod +x install.sh
sudo ./install.sh
```
Usage
-
```
sudo ipchanger
```
When you will be asked to type a new IP and prefix, you have 2 possibilities:
- Option 1 (IP/prefix) useful if you have more than 1 network adapter:
```
192.168.1.10/24
```
- Option 2 (IP/prefix/gateway):
```
192.168.1.10/24/192.168.1.1
```
- Option 3 (dhcp):
```
dhcp
```

Bug report
-
jackscripter45@gmail.com
