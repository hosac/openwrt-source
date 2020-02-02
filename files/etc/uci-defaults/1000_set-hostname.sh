#!/bin/sh
#
# https://github.com/hosac | hosac@gmx.net
#

# Store existing hostname in variable
HOSTNAME=$(uci get system.@system[0].hostname)

# If hostname is still OpenWrt change it to OpenWrt-XXXXXX, otherwise do not touch it 
if [ $HOSTNAME = OpenWrt ]
then
	# Read eth0 MAC address, erase colon, use only character from 7-12, convert to upper case
	MACETH0=$(cat /sys/class/net/eth0/address | sed 's/://g' | cut -c7-12 | tr [a-z] [A-Z])

	# Set hostname and add last characters of MAC
	uci set system.@system[-1].hostname="OpenWrt-$MACETH0"

	# Commit changes
	uci commit
fi
