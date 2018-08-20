# existed resources
output "VPC_id" {
  value = "${data.aws_vpc.VPC.id}"
}
output "SUBNET_id" {
  value = "${data.aws_subnet_ids.ALL_SUBNET.ids}"
}

output "R53Zone_id" {
  value = "${data.aws_route53_zone.R53Zone.id}"
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

output "SPOT_FLEET_REQUEST_STATUS" {
  value = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.spot_request_state}"
}

output "SPOT_FLEET_REQUEST_TARGET_CAPACITY" {
  value = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.target_capacity}"
}

# ###
# output "SPOT_INSTANCE_PRIVATE_IPS" {
#   value = "${data.aws_instances.SPOT_FLEET_INSTANCE_IPS.private_ips}"
#   depends_on = ["data.aws_instances.SPOT_FLEET_INSTANCE_IPS"]
# }

# output "SPOT_INSTANCE_PUBLIC_IPS" {
#   value = "${data.aws_instances.SPOT_FLEET_INSTANCE_IPS.public_ips}"
#   depends_on = ["data.aws_instances.SPOT_FLEET_INSTANCE_IPS"]
# }

# output "SPOT_INSTANCE_PUBLIC_IDS" {
#   value = "${data.aws_instances.SPOT_FLEET_INSTANCE_IPS.ids}"
#   depends_on = ["data.aws_instances.SPOT_FLEET_INSTANCE_IPS"]
# }