#!/usr/bin/env bash

# Update System
yum update -y
yum install -y docker git make nano

# TODO - Determine the version of docker installed and download the corresponding version of docker-compose
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start Docker now that it is installed
service docker start

#----------------------------------------------
#  Create `docker` group to avoid using sudo
#----------------------------------------------

# This is a convenience step and should not be done in a production environment.
# See https://docs.docker.com/engine/installation/linux/linux-postinstall/

groupadd docker
usermod -aG docker ec2-user
reboot -f now # Required for group evaluation to take place
