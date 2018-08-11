# existed resources
output "VPC_id" {
  value = "${data.aws_vpc.VPC.id}"
}
output "SUBNET_id" {
  value = "${data.aws_subnet.PUBLIC_SUBNET.*.id}"
}

// new resources
output "LT_name" {
  value = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
}
output "SG_id" {
  value = "${aws_security_group.SG.id}"
}