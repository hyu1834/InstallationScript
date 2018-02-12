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
		echo "System detected: $distribution_name-$release_version"
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install freeglut3 freeglut3-dev
		sudo apt-get install libxmu-dev libxi-dev
	    
	    sudo ldconfig
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi