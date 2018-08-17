resource "aws_subnet" "PUBLIC_SUBNET_A" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "${var.SUBNET-PUBLIC-AZA-CIDR}"
  tags {
        Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }
 availability_zone = "${data.aws_availability_zones.AZ_LIST.names[0]}"
}
resource "aws_subnet" "PUBLIC_SUBNET_B" {
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "${var.SUBNET-PUBLIC-AZB-CIDR}"
  tags {
        Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
  }
 availability_zone = "${data.aws_availability_zones.AZ_LIST.names[1]}"
}
resource "aws_route_table_association" "ASSOC_SUBNET_A_RT" {
    subnet_id = "${aws_subnet.PUBLIC_SUBNET_A.id}"
    route_table_id = "${aws_route_table.MAIN_RT.id}"
}
resource "aws_route_table_association" "ASSOC_SUBNET_B_RT" {
    subnet_id = "${aws_subnet.PUBLIC_SUBNET_B.id}"
    route_table_id = "${aws_route_table.MAIN_RT.id}"
}
