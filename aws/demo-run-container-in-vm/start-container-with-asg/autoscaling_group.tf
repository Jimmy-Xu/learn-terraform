resource "aws_autoscaling_group" "ASG_ON_DEMAND" {
  #availability_zones = ["${element(split(",", lookup(var.AZS, var.REGION)), count.index)}"]
  vpc_zone_identifier = ["${data.aws_subnet_ids.ALL_SUBNET.ids}"]

  desired_capacity = 0
  min_size = 0
  max_size = 0
  
  launch_template = {
    id = "${aws_launch_template.LAUNCH_TEMPLATE_ON_DEMAND.id}"
    version = "$$Latest"
  }
}

resource "aws_autoscaling_group" "ASG_SPOT" {
  #availability_zones = ["${element(split(",", lookup(var.AZS, var.REGION)), count.index)}"]
  vpc_zone_identifier = ["${data.aws_subnet_ids.ALL_SUBNET.ids}"]

  desired_capacity = 0
  min_size = 0
  max_size = 0

  launch_template = {
    id = "${aws_launch_template.LAUNCH_TEMPLATE_SPOT.id}"
    version = "$$Latest"
  }
}