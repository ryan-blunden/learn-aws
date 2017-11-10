#! /usr/bin/env bash

# Update System
yum update -y
yum install -y docker git

# Start Docker now that it is installed
service docker start

# Pull down latest DevLibs source, build and run Docker API container
git clone --depth 1 https://github.com/ryan-blunden/devlibs.git
cd devlibs
make api-run
