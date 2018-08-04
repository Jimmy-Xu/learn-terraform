# Declare the data source
data "aws_availability_zones" "AZ_LIST" {}

/* EXTERNAL NETWORG , IG, ROUTE TABLE */
resource "aws_internet_gateway" "IGW" {
   vpc_id = "${aws_vpc.VPC.id}"
    tags {
        Name = "${var.PROJECT_NAME}-IGW"
    }
}

resource "aws_network_acl" "ACL" {
    vpc_id = "${aws_vpc.VPC.id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "${var.PROJECT_NAME}-ACL" #open acl
    }
}
resource "aws_route_table" "MAIN_RT" {
  vpc_id = "${aws_vpc.VPC.id}"
  tags {
      Name = "${var.PROJECT_NAME}-MAIN_RT"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IGW.id}"
    }
}
