resource "aws_iam_role" "IAM_ROLE_FOR_LAMBDA" {
  name = "${var.PROJECT_NAME}-iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "IAM_POLICY_FOR_LAMBDA" {
    name = "${var.PROJECT_NAME}-iam_policy_for_lambda"
    role = "${aws_iam_role.IAM_ROLE_FOR_LAMBDA.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "ec2:DescribeInstances"
        ],
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
           "ec2:DescribeInstances",
           "ec2:CreateNetworkInterface",
           "ec2:AttachNetworkInterface",
           "ec2:DescribeNetworkInterfaces",
           "ec2:DeleteNetworkInterface"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_lambda_function" "UPDATE_R53_RECORD" {
  filename         = "script/update_r53_record.zip"
  function_name    = "update_r53_record"
  role             = "${aws_iam_role.IAM_ROLE_FOR_LAMBDA.arn}"
  handler          = "update_r53_record.handler"
  source_code_hash = "${base64sha256(file("script/update_r53_record.zip"))}"
  runtime          = "python2.7"
  vpc_config {
    subnet_ids         = ["${data.aws_subnet_ids.ALL_SUBNET.ids}"]
    security_group_ids = ["${aws_security_group.SG.id}"]
  }
  environment {
    variables = {
      project_name = "${var.PROJECT_NAME}"
      dns_zone_name = "${var.DNS_ZONE_NAME}"
    }
  }
}

resource "aws_cloudwatch_event_rule" "CLW_EVT_RULE" {
  name = "${var.PROJECT_NAME}-clw_event_rule"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ]
}
PATTERN
  depends_on = ["aws_lambda_function.UPDATE_R53_RECORD"]
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "CLW_EVT_TGT" {
  target_id = "${var.PROJECT_NAME}-clw_event_target"
  rule = "${aws_cloudwatch_event_rule.CLW_EVT_RULE.name}"
  arn = "${aws_lambda_function.UPDATE_R53_RECORD.arn}"
  input = <<INPUT
INPUT
}

resource "aws_lambda_permission" "CLW_EVT_PERMISSION" {
  statement_id = "${var.PROJECT_NAME}-lambda_permission"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.UPDATE_R53_RECORD.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.CLW_EVT_RULE.arn}"
}

# resource "aws_lambda_function" "check_foo" {
#     filename = "check_foo.zip"
#     function_name = "checkFoo"
#     role = "arn:aws:iam::424242:role/something"
#     handler = "index.handler"
# }

# resource "aws_cloudwatch_event_rule" "every_five_minutes" {
#     name = "every-five-minutes"
#     description = "Fires every five minutes"
#     schedule_expression = "rate(5 minutes)"
# }

# resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
#     rule = "${aws_cloudwatch_event_rule.every_five_minutes.name}"
#     target_id = "check_foo"
#     arn = "${aws_lambda_function.check_foo.arn}"
# }

# resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
#     statement_id = "AllowExecutionFromCloudWatch"
#     action = "lambda:InvokeFunction"
#     function_name = "${aws_lambda_function.check_foo.function_name}"
#     principal = "events.amazonaws.com"
#     source_arn = "${aws_cloudwatch_event_rule.every_five_minutes.arn}"
# }