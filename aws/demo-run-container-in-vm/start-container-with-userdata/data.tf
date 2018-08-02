# existed resource

data "aws_vpc" "VPC" {
  filter {
    name = "tag:Name"
    values = ["${var.DEMO_NAME}-VPC"]
  }
}

# get all subnets
data "aws_subnet_ids" "ALL_SUBNET" {
  tags {
    Name = "${var.DEMO_NAME}-PUBLIC_SUBNET"
  }
  vpc_id = "${data.aws_vpc.VPC.id}"
}
# get specified subnet
data "aws_subnet" "PUBLIC_SUBNET" {
    count = "${length(data.aws_subnet_ids.ALL_SUBNET.ids)}"
    id = "${data.aws_subnet_ids.ALL_SUBNET.ids[count.index]}"
    vpc_id = "${data.aws_vpc.VPC.id}"
}

# get sg
data "aws_security_group" "SG" {
  filter {
    name   = "tag:Name"
    values = ["${var.DEMO_NAME}-SG"]
  }
  vpc_id = "${data.aws_vpc.VPC.id}"
}

