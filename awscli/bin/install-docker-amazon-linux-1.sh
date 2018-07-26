#!/usr/bin/env bash

# This is for Amazon Linux 1

# Update System
yum update -y
yum install -y docker git make nano

curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
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
