output "vpc_id" {
  value = "${aws_vpc.VPC.id}"
}

output "project_name" {
  value = "${var.PROJECT_NAME}"
}