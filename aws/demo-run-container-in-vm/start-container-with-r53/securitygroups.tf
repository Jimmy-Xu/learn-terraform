resource "aws_security_group" "SG" {
  name = "SG"
  tags {
        Name = "${var.PROJECT_NAME}-SG"
  }
  description = "allow http, ssh and docker"
  vpc_id = "${data.aws_vpc.VPC.id}"

  #nginx port
  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  #docker dynamic port range
  ingress {
        from_port = 49000
        to_port = 49900
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  #docker daemon port
  ingress {
        from_port = 5732
        to_port = 5732
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
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
