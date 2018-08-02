# existed resource

# get all subnets
data "aws_subnet_ids" "ALL_SUBNET" {
  vpc_id = "${var.VPC_ID}"
  tags {
    Name = "${var.DEMO_NAME}-PUBLIC_SUBNET"
  }
}
# get specified subnet
data "aws_subnet" "PUBLIC_SUBNET" {
    id = "${data.aws_subnet_ids.ALL_SUBNET.0}"
    vpc_id = "${var.VPC_ID}"
}

# get sg
data "aws_security_group" "SG" {
  filter {
    name   = "tag:Name"
    values = ["${var.DEMO_NAME}-SG"]
  }
  vpc_id = "${var.VPC_ID}"
}