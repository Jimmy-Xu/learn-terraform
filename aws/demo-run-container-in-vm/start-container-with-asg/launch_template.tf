resource "aws_iam_role" "IAM_ROLE_FOR_EC2_INSTANCE" {
  name = "${var.PROJECT_NAME}-iam_for_ec2_instance"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# add permission to ec2 instance
resource "aws_iam_role_policy" "IAM_POLICY_FOR_EC2_INSTANCE" {
    name = "${var.PROJECT_NAME}-iam_policy_for_ec2_instance"
    role = "${aws_iam_role.IAM_ROLE_FOR_EC2_INSTANCE.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
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

resource "aws_iam_instance_profile" "IAM_INSTANCE_PROFILE" {
  name = "${var.PROJECT_NAME}-iam_instance_profile"
  role = "${aws_iam_role.IAM_ROLE_FOR_EC2_INSTANCE.name}"
}

## issue： if update  launch_template, valid_until will be changed, cause https://github.com/terraform-providers/terraform-provider-aws/issues/5455
### "Error creating AutoScaling Group: InvalidQueryParameter: Incompatible launch template: Auto Scaling only supports the 'one-time' Spot instance type with no duration."
resource "aws_launch_template" "LAUNCH_TEMPLATE_SPOT" {
    image_id           = "${lookup(var.AMI_ECS_OPTIMIZED, var.REGION)}"
    instance_type      = "t2.micro"
    key_name           = "${var.PROJECT_NAME}-kp"
    iam_instance_profile {
       arn = "${aws_iam_instance_profile.IAM_INSTANCE_PROFILE.arn}"
    }
    instance_market_options {
        market_type = "spot"                  #  The market type. Can be "spot"
        spot_options {        
            spot_instance_type = "one-time"
            max_price = "0.0035"
            instance_interruption_behavior = "terminate"
        }
    }

    tags {
          Name = "${var.PROJECT_NAME}-LT_SPOT"
    }
    tag_specifications {
      resource_type = "instance"
      tags {
        Name = "${var.PROJECT_NAME}-ASG-Spot-ContainerVM"
        Type = "spot"
        ServiceName = "${var.SERVICE_NAME}"
      }
    }
    vpc_security_group_ids = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"]
    #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
    #user_data(base64)
    #use iam_instance_profile to execute aws cli in user data without credential
    user_data = "${base64encode(file("script/user_data.sh"))}"
}

resource "aws_launch_template" "LAUNCH_TEMPLATE_ON_DEMAND" {
    image_id           = "${lookup(var.AMI_ECS_OPTIMIZED, var.REGION)}"
    instance_type      = "t2.micro"
    key_name           = "${var.PROJECT_NAME}-kp"
    iam_instance_profile {
       arn = "${aws_iam_instance_profile.IAM_INSTANCE_PROFILE.arn}"
    }
    tags {
          Name = "${var.PROJECT_NAME}-LT_ON_DEMAND"
    }
    tag_specifications {
      resource_type = "instance"
      tags {
        Name = "${var.PROJECT_NAME}-ASG-OnDemand-ContainerVM"
        Type = "on-demand"
        ServiceName = "${var.SERVICE_NAME}"
      }
    }
    vpc_security_group_ids = ["${data.aws_security_group.GLOBAL_SG.id}","${aws_security_group.SG.id}"]
    #the userdata script will be executed as root; if the uesrdata changed, the old instance will be replaced by a new one when apply
    #user_data(base64)
    #use iam_instance_profile to execute aws cli in user data without credential
    user_data = "${base64encode(file("script/user_data.sh"))}"
}