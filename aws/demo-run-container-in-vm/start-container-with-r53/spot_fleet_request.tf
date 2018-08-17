resource "aws_iam_role" "IAM_ROLE_FOR_SPOT_FLEET" {
  name = "${var.PROJECT_NAME}-iam_for_spotfleet"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "spotfleet.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "IAM_POLICY_FOR_SPOT_FLEET" {
    name = "${var.PROJECT_NAME}-iam_policy_for_spotfleet"
    role = "${aws_iam_role.IAM_ROLE_FOR_SPOT_FLEET.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeImages",
                "ec2:DescribeSubnets",
                "ec2:RequestSpotInstances",
                "ec2:TerminateInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:CreateTags"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": [
                        "ec2.amazonaws.com",
                        "ec2.amazonaws.com.cn"
                    ]
                }
            },
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:RegisterTargets"
            ],
            "Resource": [
                "*"
            ]
        },

        {
            "Effect": "Allow",
            "Action": [
                "route53domains:Get*",
                "route53domains:List*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:Get*",
                "route53:List*",
                "route53:TestDNSAnswer"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_spot_fleet_request" "SPOT_FLEET_REQUEST" {
    iam_fleet_role = "${aws_iam_role.IAM_ROLE_FOR_SPOT_FLEET.arn}"
    spot_price = "0.0035"
    target_capacity = 1
    on_demand_target_capacity = 0
    valid_until = "2019-08-16T14:53:08Z"
    terminate_instances_with_expiration = true
    wait_for_fulfillment = true
    launch_template_configs {
      launch_template_specification {
        name = "${aws_launch_template.LAUNCH_TEMPLATE.name}"
        version = "${aws_launch_template.LAUNCH_TEMPLATE.latest_version}"
      }
    }
    depends_on = ["aws_launch_template.LAUNCH_TEMPLATE"]
}