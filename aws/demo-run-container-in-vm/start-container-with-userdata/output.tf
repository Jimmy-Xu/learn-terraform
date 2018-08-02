output "ContainerVM_ip" {
  value = "${aws_instance.ContainerVM.*.public_ip}"
}