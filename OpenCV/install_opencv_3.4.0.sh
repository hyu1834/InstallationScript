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

		sudo apt-get remove x264 libx264-dev
 
		sudo apt-get install build-essential checkinstall cmake pkg-config yasm
		sudo apt-get install git gfortran
		sudo apt-get install libjpeg8-dev libjasper-dev libpng12-dev

		if [ "$release_version" = "16.04" ]
		then
			sudo apt-get install -y libtiff5-dev
		elif [ "$release_version" = "14.04" ]
		then
			sudo apt-get install -y libtiff4-dev
		fi
		 
		sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
		sudo apt-get install -y libxine2-dev libv4l-dev
		sudo apt-get install -y libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
		sudo apt-get install -y qt5-default libgtk2.0-dev libtbb-dev
		sudo apt-get install -y libatlas-base-dev
		sudo apt-get install -y libfaac-dev libmp3lame-dev libtheora-dev
		sudo apt-get install -y libvorbis-dev libxvidcore-dev
		sudo apt-get install -y libopencore-amrnb-dev libopencore-amrwb-dev
		sudo apt-get install -y x264 v4l-utils
		 
		# Optional dependencies
		sudo apt-get install -y libprotobuf-dev protobuf-compiler
		sudo apt-get install -y libgoogle-glog-dev libgflags-dev
		sudo apt-get install -y libgphoto2-dev libeigen3-dev libhdf5-dev

		# Install OpenCV for python
		sudo apt-get install -y python-dev python-pip python3-dev python3-pip
		sudo -H pip2 install -U pip numpy
		sudo -H pip3 install -U pip numpy
		
		sudo pip install opencv-python
		sudo pip3 install opencv-python

		git clone https://github.com/opencv/opencv.git
		cd opencv 
		git checkout 3.4.0

		git clone https://github.com/opencv/opencv_contrib.git
		cd opencv_contrib
		git checkout 3.4.0
		cd ..

		mkdir build
		cd build
 
		# compile and install
		cmake -D CMAKE_BUILD_TYPE=RELEASE \
		      -D CMAKE_INSTALL_PREFIX=/usr/local \
		      -D INSTALL_C_EXAMPLES=ON \
		      -D INSTALL_PYTHON_EXAMPLES=ON \
		      -D WITH_TBB=ON \
		      -D WITH_V4L=ON \
		      -D WITH_QT=ON \
		      -D WITH_OPENGL=ON \
		      -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
		      -D BUILD_EXAMPLES=ON ..
		
		make all -j4 # 4 cores
		sudo make install
		sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
		sudo ldconfig
	fi
elif [ "$system_platform" = "Darwin" ]
then
	echo "OSX"
else
	echo "Window"
fi
