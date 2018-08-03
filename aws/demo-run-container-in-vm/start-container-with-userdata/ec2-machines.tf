resource "aws_instance" "ContainerVM" {
  ami           = "${lookup(var.AMI, var.REGION)}"
  instance_type = "t2.nano"
  associate_public_ip_address = "true"
  subnet_id = "${data.aws_subnet.PUBLIC_SUBNET.id}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  key_name = "${var.KP}"
  tags {
        Name = "${var.DEMO_NAME}-ContainerVM"
  }
  #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
  user_data = <<HEREDOC
#!/bin/bash

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

## Start nginx container
docker run -d -p 80:80 nginx
HEREDOC
}

# resource "aws_route53_record" "R53Record" {
#    zone_id = "${aws_route53_zone.R53Zone.zone_id}"
#    name = "myweb.${var.DNS_ZONE_NAME}"
#    type = "A"
#    ttl = "300"
#    records = ["${aws_instance.ContainerVM.private_ip}"]
# }
