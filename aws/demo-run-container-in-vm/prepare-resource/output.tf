output "project_name" {
  value = "${var.PROJECT_NAME}"
}

output "key_pair" {
  value = "${aws_key_pair.KEY_PAIR.key_name}"
}

output "vpc_id" {
  value = "${aws_vpc.VPC.id}"
}

output "subnet_ids" {
  value = "${data.aws_subnet_ids.ALL_SUBNET.ids}"
}

output "az" {
  value = "${data.aws_availability_zones.AZ_LIST.names}"
}

output "igw_id" {
  value = "${aws_internet_gateway.IGW.id}"
}

output "rtb_id" {
  value = "${aws_route_table.MAIN_RT.id}"
}

output "r53_zone_id" {
  value = "${aws_route53_zone.R53Zone.zone_id}"
}