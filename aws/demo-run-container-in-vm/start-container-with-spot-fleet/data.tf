################################
# existed resource
################################

data "aws_availability_zones" "AZ_LIST" {
  state = "available"
}

data "aws_vpc" "VPC" {
  filter {
    name = "tag:Name"
    values = ["${var.PROJECT_NAME}-VPC"]
  }
}

# get all subnets
data "aws_subnet_ids" "ALL_SUBNET" {
  tags {
    Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }
  vpc_id = "${data.aws_vpc.VPC.id}"
}
# get specified subnet
data "aws_subnet" "PUBLIC_SUBNET" {
    count = "${length(data.aws_subnet_ids.ALL_SUBNET.ids)}"
    id = "${data.aws_subnet_ids.ALL_SUBNET.ids[count.index]}"
    vpc_id = "${data.aws_vpc.VPC.id}"
}

data "aws_security_group" "GLOBAL_SG" {
    name = "${var.PROJECT_NAME}-SG-global"
    vpc_id = "${data.aws_vpc.VPC.id}"
}

data "aws_iam_role" "IAM_ROLE" {
    name = "aws-ec2-spot-fleet-tagging-role"
}

data "aws_instances" "SPOT_FLEET_INSTANCE_IPS" {
  instance_tags {
    Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
  }
  filter {
    name   = "tag:Name"
    values = ["${var.PROJECT_NAME}-SpotFleet-ContainerVM"]
  }
}

################################
# cert file for docker daemon
################################
data "template_file" "CERT_CA" {
  template = "${file("cert/ca.pem")}"
}

data "template_file" "CERT_SERVER" {
  template = "${file("cert/server.pem")}"
}

data "template_file" "CERT_SERVER_KEY" {
  template = "${file("cert/server-key.pem")}"
}

