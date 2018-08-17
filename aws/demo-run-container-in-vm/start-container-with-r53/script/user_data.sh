#!/bin/bash
##  The scripts run as root not ec2-user

## output userdata log
exec &> /var/log/userdata.log

echo "START: "`date "+%Y-%m-%d %H:%M:%S"`

## Disable SSH Host Key Checking for user ec2-user
echo -e "Host *\n    StrictHostKeyChecking no" > /home/ec2-user/.ssh/config
chown ec2-user:ec2-user /home/ec2-user/.ssh/config

## Start nginx container
docker run -d -p 80:80 nginx

echo "END: "`date "+%Y-%m-%d %H:%M:%S"`

## list r53 zone
yum install -y python27-pip
pip install awscli
/usr/local/bin/aws route53 list-hosted-zones > /home/ec2-user/zone.txt 2>&1

echo "OS START: "`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
