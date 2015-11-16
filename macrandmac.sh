#!/bin/bash
# macrandmac
# works on yosemite and el capitan.

# check if the SSID is in the list
grep '^'$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')'$' macrandmac_whitelist.txt

# checks the exit code of grep 
if [ "b$?" == "b0" ]; then 
	sudo ifconfig en0 down
	sudo ifconfig en0 up
	
	#display notification:
	osascript -e 'display notification "SSID '$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')' on whitelist" with title "MAC Reverted" subtitle "Set MAC to '$(cat .temp_mac | awk '{print toupper($0)}')'"'
	rm .temp_mac
else
	# Generate MAC
	echo "Setting MAC to $(echo "$(head -$((${RANDOM} % `wc -l < macrandmac_oui.txt` + 5)) macrandmac_oui.txt | tail -1):$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//')" | tee .temp_mac) with OUI from list \"$(head -3 oui.txt | tail -1 | cut -c 3-)\""
	
	# set interface MAC
	sudo ifconfig en0 ether $(cat .temp_mac)
	
	echo "macchangemac-v0,en0,$(date +"%s"),$(cat .temp_mac),$(ifconfig | grep -m 2 "inet " | grep -v 127.0.0.1 | awk '{print $2}'),$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')" >> macrandmac_log.log
	
	# interface down/up
	sudo ifconfig en0 down
	sudo ifconfig en0 up
	
	# notification
	osascript -e 'display notification "Using '$(head -3 macrandmac_oui.txt | tail -1 | cut -c 3-)' OUI" with title "MAC Changed" subtitle "Set MAC to '$(cat .temp_mac | awk '{print toupper($0)}')'"'
fi
