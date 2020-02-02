#!/bin/sh
#
# https://github.com/hosac | hosac@gmx.net
#

#  If the password is blank (standard), set it to the individual one "PassworD"
if [ -n "$(grep 'root::' /etc/shadow)" ]; then
	sed -i -e 's/root::/root:$1$Jwewbqfp$xnDLrazpJrxfv7OssFKdf.:/g' /etc/shadow
fi
