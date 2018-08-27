resource "aws_elb" "ELB" {
    name = "${var.PROJECT_NAME}-elb"
    subnets = ["${data.aws_subnet_ids.ALL_SUBNET.ids}"]  # for vpc
    security_groups = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"] # for vpc
    # access_logs {
    #     bucket = "elb-log"
    #     bucket_prefix = "elb"
    #     interval = 5
    # }
    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = 80
        instance_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags {
        Name = "${var.PROJECT_NAME}-elb"
    }
}

resource "aws_lb_cookie_stickiness_policy" "ELB_COOKIE_STICKNESS_POLICY" {
    name = "${var.PROJECT_NAME}-cookiestickness"
    load_balancer = "${aws_elb.ELB.id}"
    lb_port = 80
    cookie_expiration_period = 600
}