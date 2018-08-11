# existed resources
output "VPC_id" {
  value = "${data.aws_vpc.VPC.id}"
}
output "SUBNET_id" {
  value = "${data.aws_subnet.PUBLIC_SUBNET.*.id}"
}

// new resources
output "SG_id" {
  value = "${aws_security_group.SG.id}"
}

output "LT_id" {
  value = "${aws_launch_template.LAUNCH_TEMPLATE.id}"
}

output "SFR_id" {
  value = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
}

output "SPOT_INSTANCE_IPS" {
  value = "${data.aws_instances.SPOT_FLEET_INSTANCE_IPS.*.id}"
}