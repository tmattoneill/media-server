# media-server
Setup files for a self-hosted media server

## Requirements
* Server with 500GB HDD
* 16GB RAM
* Ubuntu Server LTS 20+
* External storage as needed

## Setting up the server
Once logged into the fresh install as a user with sudo privilidges run:

    sudo apt update -y && sudo apt upgrade -y

Next, clone the github repo onto the new machine:

    git clone https://github.com/tmattoneill/media-server
    
Go into the new directory

    cd media-server
    
and run the install script:

    source ./media-server.sh

## Setting up git

* https://blog.corsego.com/aws-cloud9-github-ssh

```
    ssh-keygen -t ed25519 -C "[GITHUB_EMAIL_LOGIN]" \
    eval "$(ssh-agent)" \
    ssh-add ~/.ssh/id_ed25519.pub \
    nano ~./ssh/id_ed25519.pub \
    ssh -T git@github.com \
    git remote -v \
    cd ~/media-server/ \
    git remote -v \
    git remote set-url origin git@github.com:[USERNAME]/[REPO].git
```

## Configuring the Server

## Configuring SABNZBD
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_001.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_002.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_003.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_004.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_005a.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_005b.png" width=66%>

## Configuring Radarr (TV)

## Configuring Sonarr (Movies)

## Confguring Plex (Media Server)
