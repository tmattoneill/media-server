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

## Setting up git [OPTIONAL]

* Start by configuring git locally

```
git config --global user.email "[YOUR EMAIL]" &&
git config --global user.name "[YOUR FULL NAME]"
```

* Instructions from: https://blog.corsego.com/aws-cloud9-github-ssh

```
ssh-keygen -t ed25519 -C "[GITHUB_EMAIL_LOGIN]"
```

```
eval "$(ssh-agent)" && \
ssh-add ~/.ssh/id_ed25519.pub && chmod 600 ~/.ssh/id_ed25519.pub && \
ssh -T git@github.com && \
cd ~/media-server/ && \
git remote -v 
```

```
git remote set-url origin git@github.com:[GITHUB_USERNAME]/[GIT_REPO_NAME].git
```

## Configuring the Server

## Configuring SABNZBD
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_001.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_002.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_003.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_004.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_005a.png" width=66%>
<img src="https://github.com/tmattoneill/media-server/blob/main/images/sabnzbd_005b.png" width=66%>

## Configuring Radarr (Movies)

## Configuring Sonarr (TV)

 * https://www.rapidseedbox.com/blog/ultimate-guide-to-sonarr

## Confguring Plex (Media Server)
