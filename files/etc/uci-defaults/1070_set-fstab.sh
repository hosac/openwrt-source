#!/bin/sh
#
# https://github.com/hosac | hosac@gmx.net
#

# Set fstab to enable automount of devices
uci set fstab.@global[0].anon_mount='1'
uci set fstab.@global[0].check_fs='1'

# Commit changes
uci commit

# Restart fstab daemon
/etc/init.d/fstab restart
