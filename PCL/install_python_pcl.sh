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
		./install_pcl1.7.sh

		# check what version of ubuntu version is it
		if [ "$release_version" = "16.04" ]
		then
			sudo apt-get install python3 cmake build-essential devscripts python-sphinx dh-exec libqt4-opengl-dev libusb-1.0-0-dev doxygen doxygen-latex libproj-dev cython
		# elif [ "$release_version" = "14.04" ]
		# then

		fi

		git clone https://github.com/strawlab/python-pcl.git
		cd python-pcl

		sudo pip3 install --upgrade pip3
		sudo pip3 install cython==0.25.2
		sudo pip3 install numpy
		python3 setup.py build_ext -i
		python3 setup.py install

		sudo ldconfig
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi