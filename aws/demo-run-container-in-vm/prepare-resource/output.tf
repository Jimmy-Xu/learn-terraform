output "vpc_id" {
  value = "${aws_vpc.VPC.id}"
}

output "project_name" {
  value = "${var.PROJECT_NAME}"
}

output "key_pair" {
  value = "${aws_key_pair.KEY_PAIR.key_name}"
}