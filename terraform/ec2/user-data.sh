#!/usr/bin/env bash

# Update system
yum yum clean all
yum update -y
yum upgrade

# Install required dependencies
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

# Install the memory and disk monitoring metrics and send to Cloud Watch
#
# Not quire ready yet.
#
#sudo yum install perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https -y
#curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
#unzip CloudWatchMonitoringScripts-1.2.2.zip
#rm CloudWatchMonitoringScripts-1.2.2.zip
#cd aws-scripts-mon
#(crontab -l && echo "*/5 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron") | crontab -
