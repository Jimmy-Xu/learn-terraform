resource "aws_instance" "ContainerVM" {
  ami           = "${lookup(var.AMI, var.REGION)}"
  instance_type = "t2.nano"
  associate_public_ip_address = "true"
  subnet_id = "${data.aws_subnet_ids.ALL_SUBNET.ids[0]}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  key_name = "${var.PROJECT_NAME}-kp"
  tags {
        Name = "${var.PROJECT_NAME}-ContainerVM"
  }
  provisioner "local-exec" {
    command = "echo 'CHECK_NGINX:'`date`;curl -s http://${self.public_ip} >/dev/null; while [ $? -ne 0 ];do sleep 1; echo `date`; curl -s http://${self.public_ip} >/dev/null; done"
  }

  #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
  # user_data_base64(base64), user_data(plain)
  user_data = <<HEREDOC
#!/bin/bash

## output userdata log
exec &> /var/log/userdata.log

echo "START: "`date "+%Y-%m-%d %H:%M:%S"`

## Enable the remote API with TLS authentication
mkdir -p /etc/docker

cat> /etc/docker/ca.pem <<EOF
${data.template_file.CERT_CA.rendered}
EOF

cat> /etc/docker/server.pem <<EOF
${data.template_file.CERT_SERVER.rendered}
EOF

cat> /etc/docker/server-key.pem <<EOF
${data.template_file.CERT_SERVER_KEY.rendered}
EOF

mkdir -p /run/systemd/system/docker.service.d
echo -e "[Service]\nEnvironment=DOCKER_OPTS=\"-H tcp://0.0.0.0:5732 --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server.pem --tlskey=/etc/docker/server-key.pem\"" > /run/systemd/system/docker.service.d/remote.conf
systemctl daemon-reload
systemctl restart docker


## Disable SSH Host Key Checking for user core
echo -e "Host *\n    StrictHostKeyChecking no" > /home/core/.ssh/config
chown core:core /home/core/.ssh/config

echo "MIDDLE: "`date "+%Y-%m-%d %H:%M:%S"`

## Start nginx container
docker run -d -p 80:80 nginx

echo "END: "`date "+%Y-%m-%d %H:%M:%S"`

echo "OS START: "`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
HEREDOC
}

# resource "aws_route53_record" "R53Record" {
#    zone_id = "${aws_route53_zone.R53Zone.zone_id}"
#    name = "docker.${var.DNS_ZONE_NAME}"
#    type = "A"
#    ttl = "300"
#    records = ["${aws_instance.ContainerVM.*.public_ip}"]
# }
