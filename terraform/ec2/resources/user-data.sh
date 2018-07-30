#!/usr/bin/env bash

# Update system
yum yum clean all
yum update -y
yum upgrade

# Install required dependencies
yum install -y docker git make nano python3
pip3 install pip setuptools --upgrade
pip3 install docker-compose

service docker start

# Install the memory and disk monitoring metrics and send to Cloud Watch
yum install perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https -y
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
unzip CloudWatchMonitoringScripts-1.2.2.zip
rm CloudWatchMonitoringScripts-1.2.2.zip
cd aws-scripts-mon
(crontab -l && echo "*/5 * * * * /aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron") | crontab -
