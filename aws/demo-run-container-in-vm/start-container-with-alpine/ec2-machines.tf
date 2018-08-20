resource "aws_instance" "AlpineVM" {
  ami           = "${lookup(var.AMI, var.REGION)}"
  instance_type = "t2.nano"
  associate_public_ip_address = "true"
  subnet_id = "${data.aws_subnet_ids.ALL_SUBNET.ids[0]}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  key_name = "${var.PROJECT_NAME}-kp"
  tags {
        Name = "${var.PROJECT_NAME}-AlpineVM"
  }

  #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
  # user_data_base64(base64), user_data(plain)
  user_data = <<HEREDOC
#!/bin/bash

## output userdata log
exec &> /var/log/userdata.log

echo "START: "`date "+%Y-%m-%d %H:%M:%S"`

echo "END: "`date "+%Y-%m-%d %H:%M:%S"`

echo "OS START: "`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
HEREDOC
}

# resource "aws_route53_record" "R53Record" {
#    zone_id = "${aws_route53_zone.R53Zone.zone_id}"
#    name = "docker.${var.DNS_ZONE_NAME}"
#    type = "A"
#    ttl = "300"
#    records = ["${aws_instance.AlpineVM.*.public_ip}"]
# }
