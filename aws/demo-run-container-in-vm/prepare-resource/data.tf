# Declare the data source
data "aws_availability_zones" "AZ_LIST" {
  state = "available"
}

data "aws_subnet_ids" "ALL_SUBNET" {
  tags {
    Role = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }
  vpc_id = "${aws_vpc.VPC.id}"
}