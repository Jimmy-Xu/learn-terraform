resource "aws_iam_role" "IAM_FOR_LAMBDA" {
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

resource "aws_lambda_function" "UPDATE_R53_RECORD" {
  filename         = "script/update_r53_record.zip"
  function_name    = "hyperUpdateR53Record"
  role             = "${aws_iam_role.IAM_FOR_LAMBDA.arn}"
  handler          = "hyperUpdateR53Record.handler"
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