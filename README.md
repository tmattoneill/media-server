# media-server
Setup files for a hosted media server

# Requirements
* Server with 500GB HDD
* 16GB RAM
* Ubuntu Server LTS 20+
* External storage as needed

# Setting up the server
Once logged into the fresh install as a user with sudo privilidges run:

    ![#c5f015]sudo apt update -y && sudo apt upgrade -y

Next, clone the github repo onto the new machine:

    git clone https://github.com/tmattoneill/media-server
    
Go into the new directory

    cd media-server
    
and run the install script:

    source ./media-server.sh
