resource "aws_launch_template" "LAUNCH_TEMPLATE" {
    image_id           = "${lookup(var.AMI, var.REGION)}"
    instance_type = "t2.micro"
    key_name = "${var.KP}"
    network_interfaces {
      associate_public_ip_address = true
      delete_on_termination = true
      subnet_id = "${data.aws_subnet.PUBLIC_SUBNET.id}"
      security_groups = ["${aws_security_group.SG.id}"]
    }
    tags {
          Name = "${var.PROJECT_NAME}-LC"
    }
    tag_specifications {
      resource_type = "instance"
      tags {
        Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
      }
    }
    #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
    user_data = <<HEREDOC
#!/bin/bash

## output userdata log
exec &> /var/log/userdata.log

echo "START: "`date "+%Y-%m-%d %H:%M:%S"`

## Disable SSH Host Key Checking for user core
echo -e "Host *\n    StrictHostKeyChecking no" > /home/core/.ssh/config
chown core:core /home/core/.ssh/config

## Start nginx container
docker run -d -p 80:80 nginx

echo "END: "`date "+%Y-%m-%d %H:%M:%S"`

echo "OS START: "`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
HEREDOC
}