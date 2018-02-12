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
		sudo apt-get -y update
		sudo apt-get -y upgrade
		sudo snap install slack --classic
	    sudo ldconfig
	    sudo shutdown -r now
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi
