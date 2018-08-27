resource "aws_lb" "ALB" {
  name               = "${var.PROJECT_NAME}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"]
  subnets            = ["${data.aws_subnet_ids.ALL_SUBNET.ids}"]

  enable_deletion_protection = false

  ip_address_type = "ipv4"

#   access_logs {
#     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags {
      Name = "${var.PROJECT_NAME}-alb"
  }
}

resource "aws_lb_target_group" "ALB_TARGET_GROUP" {
  name     = "${var.PROJECT_NAME}-alb-target-group"  # Target group name can only contain characters that are alphanumeric characters or hyphens(-)
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.VPC.id}"
}

resource "aws_lb_listener" "ALB_LISTENER" {
  load_balancer_arn = "${aws_lb.ALB.arn}"
  port              = "80"
  protocol          = "HTTP" # HTTP | HTTPS

  //default route rule
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ALB_TARGET_GROUP.arn}"
  }

  ## redirect example:
  # default_action {
  #   type = "redirect"
  #   redirect {
  #     port = "443"
  #     protocol = "HTTPS"
  #     status_code = "HTTP_301"
  #   }
  # }

}