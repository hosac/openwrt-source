
<h2>Target device</h2>

This branch is for the [Linkit Smart 7688](https://www.seeedstudio.com/LinkIt-Smart-7688.html) with [breakout board](https://www.seeedstudio.com/Breakout-for-LinkIt-Smart-7688-v2-0-p-2641.html) 

<img src="https://media-cdn.seeedstudio.site/media/catalog/product/cache/ab187aaa5f626ad16c8031644cd2de5b/h/t/httpsstatics3.seeedstudio.comproduct103100002201_04.jpg" width="250" title="Linkit7688 Image Breakout">

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

	git clone https://github.com/hosac/openwrt-source.git -b openwrt-19.07-linkitsmart7688breakout openwrt-19.07-linkitsmart7688breakout


Change to created directory

	cd openwrt-19.07-linkitsmart7688breakout


Update all latest package definitions from feeds.conf

	./scripts/feeds update -a
	
Install symlinks of all updated feeds into package/feeds

	./scripts/feeds install -a

Use a prepared config file to set needed target and/or packages (e.g. 002_targetpackages.config) and copy it to .config

	cp 002_targetpackages.config .config
	make defconfig

	
	
If you want to make changes to toolchain and firmware execute this, otherwise skip it

	make menuconfig
	
	
Run build  (with four cores try "make -j4 V=99" or higher)

	make V=99

After successful build the sysupgrade file for upload in LuCi can be found in folder /bin/targets/ramips/mt76x8/

</br>
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
	audio settings for the WM8960 audio chip, e.g. volume

- files/etc/rc.local:
	load ALSA settings using asound.state

</br>
<h2>Other modifications</h2>

- The breakout board has a WM8960 sound chip with I2C and I2S interface which is supported by DTS modification 

</br>
