#!usr/bin/env bash

# Update the operating system. Run from the command line and reboot if requested. Accept all
# default prompts.
#
# sudo apt update -y && sudo apt upgrade -y

# Check and install required packaged... Tested on 22.04 2022-10-04
#

# Set up some UI constants
#
export ESC='\033[0'
export red=$ESC';31m'
export green=$ESC';32m'
export cyan=$ESC';36m'
export default=$ESC'm'

# Define our required packages
#
export REQUIRED_PKGS=(tmux ranger net-tools git python3 docker-compose)

function chkpkg() {
	for package in ${REQUIRED_PKGS[*]}
	do
		PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package|grep "install ok installed")

		printf "${cyan}Checking for $package: $PKG_OK...\n"
		if [ "" = "$PKG_OK" ]; then
		  printf "Package $package not found. Setting up: $package.\n"
		  sudo apt-get --yes install $package 1> /dev/null
		fi
	done
}

chkpkg # executes the function chkpkg above using the required packages

# Set up required groups and users needed for the server
#
export GROUP_NAME=mediaserver # enter the name for the group managing media
echo -e -n "\e${green}"
read -p ">> What name will you use for the server? [$GROUP_NAME]: " input
GROUP_NAME=${input:-$GROUP_NAME}
printf "${default}Group <$GROUP_NAME> will be created.\n"

export USER_NAME=$(whoami) # enter the name for the user managing media
echo -e -n "\e${green}"
read -p ">> Media manager username [$USER_NAME]: " input
USER_NAME=${input:-$USER_NAME}
printf "${default}User <$USER_NAME> will be created.\n"

printf "${default}Creating user <$USER_NAME> and group <$GROUP_NAME>...\n"

# Setup media user & directories
#
sudo groupass $GROUP_NAME # Adding group `mediaserver' (GID 1002)
sudo groupadd docker

export GID=$(getent group $GROUP_NAME | cut -d: -f3)
printf "${default}Group <$GROUP_NAME> created with GID: $GID.\n"

sudo usermod -aG $GROUP_NAME $(whoami)

sudo useradd -m -s /bin/bash -g $GID $USER_NAME
printf "${green}Enter a password for <$USER_NAME>...\n"
sudo passwd $USER_NAME
sudo usermod -aG docker $USER_NAME      # Add a docker group so we won't have to sudo

printf "${default}User <$USER_NAME> (uid: $(id -u $USER_NAME)) created in group <$GROUP_NAME>.\n"

# create a root directory on the server as a mountpoint for external media
#
# first, define some variables. TODO: make this interactive with defaults
export MOUNT_POINT=ext_media

echo -e -n "\e${green}"
read -p "Which root mount point would you like [$MOUNT_POINT]: " input
MOUNT_POINT=/${input:-$MOUNT_POINT}
printf "${default}Mount point $MOUNT_POINT created at root.\n"

export MEDIA_USER_NAME=$USER_NAME
export MEDIA_USER_ID="$(id -u $USER_NAME)"

export MEDIA_GROUP_NAME=$GROUP_NAME
export MEDIA_GROUP_ID=$GID

sudo mkdir -p $MOUNT_POINT/$GROUP_NAME
sudo chown -R $USER_NAME:$GROUP_NAME /$MOUNT_POINT/$GROUP_NAME
sudo chmod -R g+w $MOUNT_POINT/$GROUP_NAME

# start the docker instances
#
#docker-compose up -d
