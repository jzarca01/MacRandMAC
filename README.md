# macrandmac
MAC Randomization script for Yosemite and El Capitan.

Features:
- MAC change logging (With SSID, IP, timestamp etc)
- Whitelist-based switching to predefined MAC based on SSID 
- Notifications
- Dictionary-based OUI (Preloaded with all Apple OUIs)

# Setup
Configure sudoers so that the following commands can run without prompting for a password:
- `sudo ifconfig en0 down`
- `sudo ifconfig en0 up`
- `sudo ifconfig en0 ether *`
  
