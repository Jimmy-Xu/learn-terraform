resource "aws_security_group" "SG" {
  name = "SG-alpine"
  tags {
        Name = "${var.PROJECT_NAME}-SG-alpine"
  }
  vpc_id = "${data.aws_vpc.VPC.id}"

  #sshd port
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
