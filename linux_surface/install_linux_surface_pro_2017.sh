#! /bin/bash
# Author: Hiu Hong Yu
# Description:
# Script to install linux-surface
# For documentation, refer to jakeday/linux-surface
# https://github.com/jakeday/linux-surface
# 

#!/bin/bash


system_platform=$(uname)
distribution_name=$(lsb_release -is)
release_version=$(lsb_release -rs)

# if the linux distribution is LINUX
if [ "$system_platform" = "Linux" ]
then
	# check whether the distribution is Ubuntu
	if [ "$distribution_name" = "Ubuntu" ]
	then
		# First make sure everything is up to date
		sudo apt-get update
		sudo apt-get upgrade

		sudo apt-get install -y git
		git clone https://github.com/jakeday/linux-surface.git

		cd linux-surface

		# Copy the files under root to /
		sudo cp -R root/* /
		# Make /lib/systemd/system-sleep/hibernate.sh as executable:
		sudo chmod a+x /lib/systemd/system-sleep/hibernate.sh
		# Extract ipts_firmware_[VERSION].zip to /lib/firmware/intel/ipts/
		sudo mkdir -p /lib/firmware/intel/ipts
		sudo unzip firmware/ipts_firmware_v102.zip -d /lib/firmware/intel/ipts/
	    #Extract i915_firmware.zip to /lib/firmware/i915/
		sudo mkdir -p /lib/firmware/i915
		sudo unzip firmware/i915_firmware.zip -d /lib/firmware/i915/

		if [ "$release_version" = "17.10" ]
		then
			sudo ln -s /lib/systemd/system/hibernate.target /etc/systemd/system/suspend.target && sudo ln -s /lib/systemd/system/systemd-hibernate.service /etc/systemd/system/systemd-suspend.service
		else
		then
			sudo ln -s /usr/lib/systemd/system/hibernate.target /etc/systemd/system/suspend.target && sudo ln -s /usr/lib/systemd/system/systemd-hibernate.service /etc/systemd/system/systemd-suspend.service
		fi

		#Install the latest marvell firmware:
		git clone git://git.marvell.com/mwifiex-firmware.git
		sudo mkdir -p /lib/firmware/mrvl/
		sudo cp mwifiex-firmware/mrvl/* /lib/firmware/mrvl/
		#Install the custom kernel and headers:
		sudo dpkg -i linux-headers-4.14.13*.deb linux-image-4.14.13*.deb
		# Remove download file
		cd ..
		rm -rf linux-surface
		#Reboot on installed kernel.
		sudo shutdown -r now
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi