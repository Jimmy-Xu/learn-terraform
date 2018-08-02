output "ContainerVM_ip" {
  value = "${aws_instance.ContainerVM.*.public_ip}"
}

output "VPC_id" {
  value = "${data.aws_vpc.VPC.id}"
}
output "SUBNET_id" {
  value = "${data.aws_subnet.PUBLIC_SUBNET.*.id}"
}
output "SG_id" {
  value = "${data.aws_security_group.SG.id}"
}
