# existed resources
output "VPC_id" {
  value = "${data.aws_vpc.VPC.id}"
}
output "SUBNET_id" {
  value = "${data.aws_subnet_ids.ALL_SUBNET.ids}"
}

// new resources
output "ContainerVM_ip" {
  value = "${aws_instance.ContainerVM.*.public_ip}"
}
output "SG_id" {
  value = "${aws_security_group.SG.id}"
}