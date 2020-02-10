
<h2>Target device</h2>

This branch is for the [Raspberry Pi](https://www.raspberrypi.org/) board family 2B/3B/3B+/CM3.

<img src="https://www.raspberrypi.org/homepage-9df4b/static/0ac033e17962a041a898d92057e60def/052d8/67d8fcc5b2796665a45f61a2e8a5bb7f10cdd3f5_raspberry-pi-3-1-1619x1080.jpg" width="250" title="Linkit7688 Image">

</br>
<h2>Image creation</h2>

<h3>Prerequisites</h3>

Install the required packages for your build system

**Ubuntu 18.04**

	sudo apt-get update
	sudo apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc zip

</br>
<h3>Clone and build</h3>
Clone this branch into the current directory

	git clone https://github.com/hosac/openwrt-source.git -b openwrt-19.07-raspberrypi32bit-openthread openwrt-19.07-raspberrypi32bit-openthread


Change to created directory

	cd openwrt-19.07-raspberrypi32bit-openthread


Update all latest package definitions from feeds.conf

	./scripts/feeds update -a
	
Install symlinks of all updated feeds into package/feeds

	./scripts/feeds install -a

Use a prepared config file to set needed target and/or packages (e.g. 002_targetpackages.config) and copy it to .config

	cp 003_openthreadpackages.config .config
	make defconfig

	
	
If you want to make changes to toolchain and firmware execute this, otherwise skip it

	make menuconfig
	
	
Run build  (with four cores try "make -j4 V=99" or higher)

	make V=99

</br>
<h2>Flash</h2>

After successful build the files can be found in folder bin/targets/brcm2708/bcm2709/

<h3>First use</h3>
Extract the zipped "factory" file and flash it to a sd-card

	cd bin/targets/brcm2708/bcm2709/
	gunzip openwrt-brcm2708-bcm2709-rpi-2-ext4-factory.img.gz

	>> Flash the .img to a sd-card (using "W32 Disk Imager" or "balenaEtcher")

<h3>Upgrade</h3>

Upgrade option via LuCi or SSH/SCP
**Do NOT extract** the openwrt-brcm2708-bcm2709-rpi-2-ext4-sysupgrade.img.gz - flash the zipped file!

	>> Upload the .img.gz to the system

<br>
<h2>Customized settings</h2>

For own settings the file system contains a /files folder, where customized files can be added to the build system
	
- files/etc/uci-defaults/1000_set-hostname.sh:
	avoid hostname "OpenWrt" and automatically generate name "OpenWrt-XXXXXX" with parts of MAC address

- files/etc/uci-defaults/1010_set-password.sh:
	avoid plain password for **root** and set it to "**PassworD**"

- files/etc/uci-defaults/1030_set-wifi.sh:
	enable Wi-Fi and avoid standard **ssid** name "OpenWrt" without encryption/password by setting "OpenWrt-XXXXXX" and wpa2-psk with password "**PassworD**"

- files/etc/uci-defaults/1070_set-fstab.sh:
	adjustments for automount of USB and SD

- files/etc/asound.state:
	settings for the audio chip, e.g. volume

- files/etc/rc.local:
	load ALSA settings using asound.state

<br>
<h2>Notes</h2>

- To get the 2.4GHz running on RPi 3B+ set "Legacy" and a defined channel. It does not work by default (auto). After first startup Wi-Fi access point is starting only in 5GHz mode
- Be aware, that in this setup **console over HDMI and USB keyboard has no password**, although root has one!
- Sound output on jack only works without HDMI connection
<br>