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

output "GLOBAL_SG_id" {
  value = "${data.aws_security_group.GLOBAL_SG.id}"
}

// new resources
output "SG_id" {
  value = "${aws_security_group.SG.id}"
}

output "LT_ON_DEMAND_id" {
  value      = "${aws_launch_template.LAUNCH_TEMPLATE_ON_DEMAND.id}"
  depends_on = ["aws_launch_template.LAUNCH_TEMPLATE_ON_DEMAND"]
}

output "LT_SPOT_id" {
  value      = "${aws_launch_template.LAUNCH_TEMPLATE_SPOT.id}"
  depends_on = ["aws_launch_template.LAUNCH_TEMPLATE_SPOT"]
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

