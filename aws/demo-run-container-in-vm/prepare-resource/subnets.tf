# create multiple subnet and route_table_association
resource "aws_subnet" "PUBLIC_SUBNET" {
    vpc_id            = "${aws_vpc.VPC.id}"
    count             = "${length(split(",", lookup(var.AZS, var.REGION)))}"
    cidr_block        = "${cidrsubnet(var.VPC_FULLC_IDR, 4, count.index)}"
    availability_zone = "${element(split(",", lookup(var.AZS, var.REGION)), count.index)}"
    #map_public_ip_on_launch = false

    tags {
        "Name" = "${var.PROJECT_NAME}-public-${element(split(",", lookup(var.AZS, var.REGION)), count.index)}"
    }
}

resource "aws_route_table_association" "ASSOC_SUBNET" {
   route_table_id = "${aws_route_table.MAIN_RT.id}"
   count = "${length(aws_subnet.PUBLIC_SUBNET.*.id)}"
   subnet_id = "${element(aws_subnet.PUBLIC_SUBNET.*.id, count.index)}"
   depends_on = [ "aws_subnet.PUBLIC_SUBNET", "aws_vpc.VPC" ]
}


# resource "aws_subnet" "PUBLIC_SUBNET_A" {
#   vpc_id = "${aws_vpc.VPC.id}"
#   cidr_block = "${var.SUBNET-PUBLIC-AZA-CIDR}"
#   tags {
#         Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
#   }
#  availability_zone = "${data.aws_availability_zones.AZ_LIST.names[0]}"
# }
# resource "aws_subnet" "PUBLIC_SUBNET_B" {
#   vpc_id = "${aws_vpc.VPC.id}"
#   cidr_block = "${var.SUBNET-PUBLIC-AZB-CIDR}"
#   tags {
#         Name = "${var.PROJECT_NAME}-PUBLIC_SUBNET"
#   }
#  availability_zone = "${data.aws_availability_zones.AZ_LIST.names[1]}"
# }
# resource "aws_route_table_association" "ASSOC_SUBNET_A_RT" {
#     subnet_id = "${aws_subnet.PUBLIC_SUBNET_A.id}"
#     route_table_id = "${aws_route_table.MAIN_RT.id}"
# }
# resource "aws_route_table_association" "ASSOC_SUBNET_B_RT" {
#     subnet_id = "${aws_subnet.PUBLIC_SUBNET_B.id}"
#     route_table_id = "${aws_route_table.MAIN_RT.id}"
# }

