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
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
		echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
		sudo apt-get update
		sudo apt-get install -y sublime-text
		sudo ldconfig
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi