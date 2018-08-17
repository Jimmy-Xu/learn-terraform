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
resource "aws_launch_template" "LAUNCH_TEMPLATE" {
    image_id           = "${lookup(var.AMI_ECS_OPTIMIZED, var.REGION)}"
    instance_type = "t2.micro"
    key_name = "${var.PROJECT_NAME}-kp"
    iam_instance_profile {
       arn = "${aws_iam_instance_profile.IAM_INSTANCE_PROFILE.arn}"
    }
    network_interfaces {
      associate_public_ip_address = true
      delete_on_termination = true
      subnet_id = "${data.aws_subnet_ids.ALL_SUBNET.ids[0]}"
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
    #use iam_instance_profile to execute aws cli in user data without credential
    user_data = "${base64encode(file("script/user_data.sh"))}"
}