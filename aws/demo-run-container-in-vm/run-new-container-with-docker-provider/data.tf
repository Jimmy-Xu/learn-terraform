data "aws_vpc" "VPC" {
  filter {
    name = "tag:Name"
    values = ["${var.PROJECT_NAME}-VPC"]
  }
}
data "aws_instance" "ContainerVM" {
  tags {
    Name = "${var.PROJECT_NAME}-ContainerVM"
  }
  vpc_id = "${data.aws_vpc.VPC.id}"
}
