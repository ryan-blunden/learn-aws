#!/usr/bin/env bash

##########################
#  Install Docker Ubuntu #
##########################

# From https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# Upgrading currently disabled
# Need to research https://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt
# apt-get upgrade -y

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce


###############################################
#  Create `docker` group to avoid using sudo  #
###############################################

# This is a convenience step and should not be done in a production environment.
# See https://docs.docker.com/engine/installation/linux/linux-postinstall/

groupadd docker
usermod -aG docker ubuntu
reboot -f now # Required for group evaluation to take place
