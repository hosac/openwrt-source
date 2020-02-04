#!/bin/sh
#
# https://github.com/hosac | hosac@gmx.net
#

# Store existing ssid in variable
SSID=$(uci get wireless.default_radio0.ssid)

# If ssid is still OpenWrt change settings, otherwise do not touch
if [ $SSID = OpenWrt ]
then
	# Read eth0 MAC address, erase colon, use only character from 7-12, convert to upper case
	MACETH0=$(cat /sys/class/net/eth0/address | sed 's/://g' | cut -c7-12 | tr [a-z] [A-Z])

	# Set Wi-Fi name and add last characters of MAC
	uci set wireless.default_radio0.ssid="OpenWrt-$MACETH0"

	# Set encryption to wpa2-psk
	uci set wireless.default_radio0.encryption='psk2'

	# Set a standard password
	uci set wireless.default_radio0.key='PassworD'

	# If wireless should be disabled after start or not
	uci set wireless.radio0.disabled='0'

	# Commit changes
	uci commit
fi
