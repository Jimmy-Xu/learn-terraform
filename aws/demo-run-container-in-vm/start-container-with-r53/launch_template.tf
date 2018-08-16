resource "aws_launch_template" "LAUNCH_TEMPLATE" {
    image_id           = "${lookup(var.AMI, var.REGION)}"
    instance_type = "t2.micro"
    key_name = "${var.KP}"
    network_interfaces {
      associate_public_ip_address = true
      delete_on_termination = true
      subnet_id = "${data.aws_subnet.PUBLIC_SUBNET.id}"
      security_groups = ["${aws_security_group.SG.id}"]
    }
    tags {
          Name = "${var.PROJECT_NAME}-LC"
    }
    tag_specifications {
      resource_type = "instance"
      tags {
        Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
      }
    }
    #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
    #user_data(base64)
    user_data = "${base64encode(file("script/user_data.sh"))}"
}