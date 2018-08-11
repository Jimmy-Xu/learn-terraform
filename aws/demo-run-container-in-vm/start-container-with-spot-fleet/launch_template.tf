resource "aws_launch_template" "LAUNCH_TEMPLATE" {
    image_id           = "${lookup(var.AMI, var.REGION)}"
    instance_type = "t2.micro"
    key_name = "${var.KP}"
    network_interfaces {
      subnet_id = "${data.aws_subnet.PUBLIC_SUBNET.id}"
      associate_public_ip_address = true
      security_groups = ["${aws_security_group.SG.id}"]
    }
    tags {
          Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
    }
}