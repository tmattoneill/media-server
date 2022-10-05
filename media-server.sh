#!/bin/bash

# Update the operating system. Run from the command line and reboot if requested. Accept all
# default prompts.
#
# sudo apt update -y && sudo apt upgrade -y

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
read -p "What name will you use for the server? [$GROUP_NAME]: " input
GROUP_NAME=${input:-$GROUP_NAME}

USER_NAME=plexmedia # enter the name for the user managing media
read -p "Media manager username [$USER_NAME]: " input
USER_NAME=${input:$USER_NAME}

printf "Creating user <$USER_NAME> and group <$GROUP_NAME>..."

# Setup media user & directories
#
sudo addgroup $GROUP_NAME # Adding group `mediaserver' (GID 1002)
export GID=$(getent group $GROUP_NAME | cut -d: -f3)
printf "Group <$GROUP_NAME> created with GID: $GID."

sudo useradd -m -s /bin/bash -g $GID $USER_NAME
echo "Enter a password for <$USER_NAME>..."
sudo passwd $USER_NAME

printf "User <$USER_NAME> (uid: $(id -u $USER_NAME)) created in group <$GROUP_NAME>."

# create a root directory on the server as a mountpoint for external media
#
# first, define some variables. TODO: make this interactive with defaults
export MOUNT_POINT=/ext_media

export MEDIA_USER_NAME=$USER_NAME
export MEDIA_USER_ID="$(id -u $USER_NAME)"

export MEDIA_GROUP_NAME=$GROUP_NAME
export MEDIA_GROUP_ID=$GID

sudo mkdir -p /$MOUNT_POINT/$GROUP_NAME
sudo chown -R $USER_NAME:$GROUP_NAME /$MOUNT_POINT/$GROUP_NAME
sudo chmod -R g+w /$MOUNT_POIINT/$GROUP_NAME

# start the docker instances
#
docker-compose up -d
