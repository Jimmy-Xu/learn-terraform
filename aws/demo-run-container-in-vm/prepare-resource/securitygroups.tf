resource "aws_security_group" "SG" {
  name = "${var.PROJECT_NAME}-SG-global"
  tags {
        Name = "${var.PROJECT_NAME}-SG-global"
  }
  description = "global SG"
  vpc_id = "${aws_vpc.VPC.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
