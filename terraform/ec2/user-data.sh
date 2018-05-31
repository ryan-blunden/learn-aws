#!/usr/bin/env bash

    yum update -y
    yum upgrade
    yum install -y docker git make nano python36

    # Add pip3 to `/usr/bin` so root/sudoers can find it.
    curl -O https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    rm get-pip.py
    ln -s /usr/local/bin/pip3 /usr/bin/pip3
    pip3 install pip setuptools --upgrade

    # Install docker-compose, adding it to `/usr/bin` so root/sudoers can find it.
    pip3 install docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    service docker start