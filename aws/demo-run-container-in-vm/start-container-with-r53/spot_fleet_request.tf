resource "aws_iam_role" "IAM_ROLE_FOR_SPOT_FLEET" {
  name = "${var.PROJECT_NAME}-iam_for_spotfleet"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
            "spotfleet.amazonaws.com",
            "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# add permisson to spot fleet
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
                "ec2:DescribeSpotFleetRequests",
                "ec2:ModifySpotFleetRequest"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DeleteAlarms"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "application-autoscaling:RegisterScalableTarget"
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
    fleet_type          = "maintain"     # maintain|request
    iam_fleet_role      = "${aws_iam_role.IAM_ROLE_FOR_SPOT_FLEET.arn}"
    spot_price          = "0.0035"
    allocation_strategy = "diversified"  # Spot 实例分布在所有池中
    valid_until         = "2019-08-16T14:53:08Z"
    target_capacity           = 2        # TargetCapacity cannot be less than OnDemandTargetCapacity
    on_demand_target_capacity = 1        # "on_demand_target_capacity": conflicts with launch_specification
    terminate_instances_with_expiration = true
    wait_for_fulfillment = true          #(Optional; Default: false) If set, Terraform will wait for the Spot Request to be fulfilled, and will throw an error if the timeout of 10m is reached.

    launch_template_configs {
      launch_template_specification {
        name = "${aws_launch_template.LAUNCH_TEMPLATE.name}"
        version = "${aws_launch_template.LAUNCH_TEMPLATE.latest_version}"
      }
      # pool1
      overrides {
        #spot_price = "0.0035"
        #instance_type = "t2.micro"
        subnet_id = "${data.aws_subnet_ids.ALL_SUBNET.ids[0]}"
      }
      # pool2
      overrides {
        #spot_price = "0.0035"
        #instance_type = "t2.micro"
        subnet_id = "${data.aws_subnet_ids.ALL_SUBNET.ids[1]}"
      }
    }

    # # pool 1
    # launch_specification {
    #     instance_type               = "t2.micro"
    #     ami                         = "${lookup(var.AMI_ECS_OPTIMIZED, var.REGION)}"
    #     key_name                    = "${var.PROJECT_NAME}-kp"        
    #     iam_instance_profile_arn    = "${aws_iam_instance_profile.IAM_INSTANCE_PROFILE.arn}"
    #     subnet_id                   = "${data.aws_subnet_ids.ALL_SUBNET.ids[0]}"
    #     weighted_capacity           = 50
    #     associate_public_ip_address = true
    #     security_groups = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"]
    #     tags {
    #         Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
    #             ServiceName = "${var.SERVICE_NAME}"
    #     }
    #     user_data = "${file("script/user_data.sh")}"
    # }
    # # pool 2
    # launch_specification {
    #     instance_type               = "t2.micro"
    #     ami                         = "${lookup(var.AMI_ECS_OPTIMIZED, var.REGION)}"
    #     key_name                    = "${var.PROJECT_NAME}-kp"        
    #     iam_instance_profile_arn    = "${aws_iam_instance_profile.IAM_INSTANCE_PROFILE.arn}"
    #     subnet_id                   = "${data.aws_subnet_ids.ALL_SUBNET.ids[1]}"
    #     weighted_capacity           = 50
    #     associate_public_ip_address = true
    #     security_groups = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"]
    #     tags {
    #         Name = "${var.PROJECT_NAME}-SpotFleet-ContainerVM"
    #             ServiceName = "${var.SERVICE_NAME}"
    #     }
    #     user_data = "${file("script/user_data.sh")}"
    # }
    depends_on = [
        "aws_iam_role_policy.IAM_POLICY_FOR_SPOT_FLEET",
        "aws_lambda_function.UPDATE_R53_RECORD",
        "aws_cloudwatch_event_target.CLW_EVT_TGT",
        "aws_cloudwatch_log_group.CLW_LOG_GROUP"
    ]
}


resource "aws_appautoscaling_target" "SPOT_FLEETR_EQUEST_AUTO_SCALING_TARGET" {
  service_namespace = "ec2"
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"
  resource_id = "spot-fleet-request/${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
  min_capacity = "0"
  max_capacity = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.target_capacity}"
}

############################################################################
# policy_type: TargetTrackingScaling
############################################################################
# resource "aws_appautoscaling_policy" "SPOT_FLEETR_EQUEST_AUTO_SCALING_POLICY_TARGETTRACKING" {
#   name = "${var.PROJECT_NAME}-spr-autoscaling-policy-targettracking"
#   service_namespace = "ec2"
#   resource_id = "spot-fleet-request/${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
#   scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"

#   policy_type = "TargetTrackingScaling"  # TargetTrackingScaling / StepScaling
#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "EC2SpotFleetRequestAverageCPUUtilization" #EC2SpotFleetRequestAverageNetworkIn|EC2SpotFleetRequestAverageNetworkOut
#     }
#     target_value = 75
#     scale_in_cooldown = 300
#     scale_out_cooldown = 300
#   }
#   depends_on = ["aws_appautoscaling_target.SPOT_FLEETR_EQUEST_AUTO_SCALING_TARGET","aws_spot_fleet_request.SPOT_FLEET_REQUEST"]
# }


############################################################################
#policy_type: StepScaling - up
############################################################################
resource "aws_cloudwatch_metric_alarm" "CLW_METRIC_ALARM_CPU_HIGH" {
  alarm_name          = "${var.PROJECT_NAME}-alarm-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2Spot"
  period              = 60
  statistic           = "Average"
  threshold           = "95"
  treat_missing_data  = "missing"

  dimensions {
    FleetRequestId = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
  }

  alarm_description = "Autoscaling CPUUtilization too high"
  alarm_actions     = ["${aws_appautoscaling_policy.SPOT_FLEETR_EQUEST_AUTO_SCALING_POLICY_STEP_UP.arn}"]
}
resource "aws_appautoscaling_policy" "SPOT_FLEETR_EQUEST_AUTO_SCALING_POLICY_STEP_UP" {
  name = "${var.PROJECT_NAME}-spr-autoscaling-policy-step-up"
  service_namespace = "ec2"
  resource_id = "spot-fleet-request/${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"

  policy_type = "StepScaling"  # TargetTrackingScaling / StepScaling
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity" # ChangeInCapacity, PercentChangeInCapacity, ExactCapacity
    metric_aggregation_type = "Average"          # Maximum, Minimum, Average
    cooldown                = 300
    step_adjustment {
        metric_interval_lower_bound = 0
        scaling_adjustment          = 1
    }
  }
  depends_on = ["aws_appautoscaling_target.SPOT_FLEETR_EQUEST_AUTO_SCALING_TARGET","aws_spot_fleet_request.SPOT_FLEET_REQUEST"]
}
############################################################################
#policy_type: StepScaling - down
############################################################################
resource "aws_cloudwatch_metric_alarm" "CLW_METRIC_ALARM_CPU_LOW" {
  alarm_name          = "${var.PROJECT_NAME}-alarm-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2Spot"
  period              = 60
  statistic           = "Average" # SampleCount, Average, Sum, Minimum, Maximum
  threshold           = "5"
  treat_missing_data  = "missing"

  dimensions {
    FleetRequestId = "${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
  }

  alarm_description = "Autoscaling CPUUtilization too low"
  alarm_actions     = ["${aws_appautoscaling_policy.SPOT_FLEETR_EQUEST_AUTO_SCALING_POLICY_STEP_DOWN.arn}"]
}
resource "aws_appautoscaling_policy" "SPOT_FLEETR_EQUEST_AUTO_SCALING_POLICY_STEP_DOWN" {
  name = "${var.PROJECT_NAME}-spr-autoscaling-policy-step-down"
  service_namespace = "ec2"
  resource_id = "spot-fleet-request/${aws_spot_fleet_request.SPOT_FLEET_REQUEST.id}"
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"

  policy_type = "StepScaling"  # TargetTrackingScaling / StepScaling
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity" # ChangeInCapacity, PercentChangeInCapacity, ExactCapacity
    metric_aggregation_type = "Average"          # Maximum, Minimum, Average
    cooldown                = 300
    step_adjustment {
        metric_interval_upper_bound = 0
        scaling_adjustment          = -1
    }
  }
  depends_on = ["aws_appautoscaling_target.SPOT_FLEETR_EQUEST_AUTO_SCALING_TARGET","aws_spot_fleet_request.SPOT_FLEET_REQUEST"]
}
