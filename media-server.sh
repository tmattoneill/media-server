#!/bin/bash

# Update the operating system
sudo apt update -y
sudo apt upgrade -y

# Check and install required packaged... Tested on 22.04 2022-10-04
#
export REQUIRED_PKGS=(tmux ranger net-tools git python3 docker-compose)

function chkpkg() {
	for package in ${REQUIRED_PKGS[*]}
	do
		PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package|grep "install ok installed")
		
		echo Checking for $package: $PKG_OK
		if [ "" = "$PKG_OK" ]; then
		  echo "Package $package not found. Setting up: $package."
		  sudo apt-get --yes install $package
		fi
	done
}

chkpkg

# Set up required groups and users needed for the server
#
GROUP_NAME=mediaserver # enter the name for the group managing media
USER_NAME=$SERVER_NAME # enter the name for the user managing media

# Setup media user & directories
sudo addgroup $GROUP_NAME # Adding group `mediaserver' (GID 1002)
export GID=$(getent group $GROUP_NAME | cut -d: -f3)
sudo useradd -m -s /bin/bash -g $GID $USER_NAME
sudo passwd $USER_NAME

# create a root directory as a mountpoint for external media
sudo mkdir -p /media/$GROUP_NAME
sudo chown -R $USER_NAME:$GROUP_NAME /media/$GROUP_NAME
sudo chmod -R g+w /media/$GROUP_NAME



