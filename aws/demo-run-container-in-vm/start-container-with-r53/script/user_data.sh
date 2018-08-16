#!/bin/bash

## output userdata log
exec &> /var/log/userdata.log

echo "START: "`date "+%Y-%m-%d %H:%M:%S"`

## Disable SSH Host Key Checking for user core
echo -e "Host *\n    StrictHostKeyChecking no" > /home/core/.ssh/config
chown core:core /home/core/.ssh/config

echo "MIDDLE: "`date "+%Y-%m-%d %H:%M:%S"`

## Start nginx container
docker run -d -p 80:80 nginx

echo "END: "`date "+%Y-%m-%d %H:%M:%S"`

echo "OS START: "`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
