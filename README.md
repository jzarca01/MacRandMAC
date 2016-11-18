# macrandmac
MAC Randomization script for 10.9 to 10.12

## Features:
- MAC change logging: Logs timestamp, SSID, IPs, and MAC to a file. 
- Whitelist: reveal a static MAC address on certain Wifi networks. 
- Notification center notifications: 
- Dictionary-based OUI: Generate plausible MACs for your hardware by using valid Apple OUIs.

## Setup
Configure sudoers so that the following commands can run without prompting for a password:
- `sudo ifconfig en0 down`
- `sudo ifconfig en0 up`
- `sudo ifconfig en0 ether *`

## Todo:
  
