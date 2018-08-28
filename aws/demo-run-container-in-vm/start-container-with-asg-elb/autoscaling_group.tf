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

  # add tag to asg: https://github.com/hashicorp/terraform/issues/15226
  tag = [
    {
      "key" = "Name"
      "value" = "${var.PROJECT_NAME}-ASG_ON_DEMAND"
      "propagate_at_launch" = true
    }
  ]

  health_check_type="ELB"
  load_balancers= ["${aws_elb.ELB.id}"]
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

  tag = [
    {
      "key" = "Name"
      "value" = "${var.PROJECT_NAME}-ASG_SPOT"
      "propagate_at_launch" = true
    }
  ]

  health_check_type="ELB"
  load_balancers= ["${aws_elb.ELB.id}"]
}