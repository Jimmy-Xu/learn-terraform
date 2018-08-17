data "aws_subnet_ids" "ALL_SUBNET" {
  tags {
    Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }
  vpc_id = "${aws_vpc.VPC.id}"
}