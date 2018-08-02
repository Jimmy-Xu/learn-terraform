data "aws_instance" "ContainerVM" {
    instance_id = "${var.INSTANCE_ID}"
}
