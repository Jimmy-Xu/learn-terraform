resource "aws_subnet" "PUBLIC_SUBNET" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "${var.Subnet-Public-AzA-CIDR}"
  tags {
        Name = "${var.DEMO_NAME}-PUBLIC_SUBNET"
  }
 availability_zone = "${data.aws_availability_zones.AZ_LIST.names[0]}"
}
resource "aws_route_table_association" "ASSOC_SUBNET_RT" {
    subnet_id = "${aws_subnet.PUBLIC_SUBNET.id}"
    route_table_id = "${aws_route_table.MAIN_RT.id}"
}
