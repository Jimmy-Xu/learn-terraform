resource "aws_instance" "ContainerVM" {
  ami           = "${lookup(var.AMI, var.REGION)}"
  instance_type = "t2.nano"
  associate_public_ip_address = "true"
  subnet_id = "${data.aws_subnet.PUBLIC_SUBNET.id}"
  vpc_security_group_ids = ["${data.aws_security_group.SG.id}"]
  key_name = "${var.KP}"
  tags {
        Name = "${var.DEMO_NAME}-ContainerVM"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  docker run -d -P nginx
HEREDOC
}

# resource "aws_route53_record" "R53Record" {
#    zone_id = "${aws_route53_zone.R53Zone.zone_id}"
#    name = "myweb.${var.DNS_ZONE_NAME}"
#    type = "A"
#    ttl = "300"
#    records = ["${aws_instance.ContainerVM.private_ip}"]
# }
