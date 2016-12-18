
# Interface: Change this to your wireless adapter. Recent notebooks probably use en0.
IF=en0

# Whitelist MAC: Use this MAC on whitelisted networks.
WLMAC="00:11:22:33:44:55"

# Check if current SSID is in the whitelist
grep '^'$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')'$' macrandmac_whitelist.txt


if [ "b$?" == "b0" ]; then # check return value of grep to see if the SSID is in the whitelist.

	# Cycle $IF
	sudo ifconfig $IF down
	sudo ifconfig $IF ether $WLMAC
	sudo ifconfig $IF up

	osascript -e 'display notification "SSID '$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')' on whitelist" with title "MAC Reverted" subtitle "Set MAC to '$(cat .temp_mac | awk '{print toupper($0)}')'"'

	rm .temp_mac

else

	# Show console notice
	echo "Setting MAC to $(echo "$(head -$((${RANDOM} % `wc -l < macrandmac_oui.txt` + 5)) macrandmac_oui.txt | tail -1):$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//')" | tee .temp_mac) with OUI from list \"$(head -3 macrandmac_oui.txt | tail -1 | cut -c 3-)\""

	sudo ifconfig $IF down
	sudo ifconfig $IF ether $(cat .temp_mac)
	sudo ifconfig $IF up
	
	echo "macchangemac,$IF,$(date +"%s"),$(cat .temp_mac),$(ifconfig | grep -m 2 "inet " | grep -v 127.0.0.1 | awk '{print $2}'),$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')" >> MAC_change.log

	
	

	osascript -e 'display notification "Using '$(head -3 macrandmac_oui.txt | tail -1 | cut -c 3-)' OUI" with title "MAC Changed" subtitle "Set MAC to '$(cat .temp_mac | awk '{print toupper($0)}')'"'
fi
