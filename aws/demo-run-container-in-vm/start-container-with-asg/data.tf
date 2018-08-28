################################
# existed resource
################################

data "aws_vpc" "VPC" {
  filter {
    name   = "tag:Name"
    values = ["${var.PROJECT_NAME}-VPC"]
  }

  default = false
}

# get all subnets
data "aws_subnet_ids" "ALL_SUBNET" {
  tags {
    Role = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }

  vpc_id = "${data.aws_vpc.VPC.id}"
}

# get specified subnet
data "aws_subnet" "PUBLIC_SUBNET" {
  count  = "${length(data.aws_subnet_ids.ALL_SUBNET.ids)}"
  id     = "${data.aws_subnet_ids.ALL_SUBNET.ids[count.index]}"
  vpc_id = "${data.aws_vpc.VPC.id}"
}

data "aws_security_group" "GLOBAL_SG" {
  name   = "${var.PROJECT_NAME}-SG-global"
  vpc_id = "${data.aws_vpc.VPC.id}"
}

data "aws_route53_zone" "R53Zone" {
  name         = "example.io."
  private_zone = true
}

# data "aws_instances" "SPOT_FLEET_INSTANCE_IPS" {
#   instance_tags {
#     Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
#   }
#   filter {
#     name   = "tag:Name"
#     values = ["${var.PROJECT_NAME}-SpotFleet-ContainerVM"]
#   }
#   depends_on = ["aws_spot_fleet_request.SPOT_FLEET_REQUEST"]
# }

