# macrandmac
MAC Randomization script for 10.9 to 10.12. 

Generate a new, but valid, MAC address on each run. Protects your privacy by preventing an adversary from uniquely identifing your machine based on the MAC. 

Whitelisting lets you use a predetermined MAC on certain networks. Useful for paid wifi hotspots, and reducing suspicion arousal when IT polks through your network logs. 

## Features:
- MAC change logging: Logs timestamp, SSID, IPs, and MAC to a file. 
- Whitelist: reveal a static MAC address on certain Wifi networks. 
- Notification center notifications
- Dictionary-based OUI: Generate plausible MACs for your hardware by using valid Apple OUIs.

## Setup
Configure sudoers so that the following commands can run without prompting for a password:
- `sudo ifconfig en0 down`
- `sudo ifconfig en0 up`
- `sudo ifconfig en0 ether *`

## Todo:
- Set whitelisting MAC per SSID, not globally
