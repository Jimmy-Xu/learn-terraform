resource "aws_spot_fleet_request" "SPOT_FLEET_REQUEST" {
    iam_fleet_role = "${data.aws_iam_role.IAM_ROLE.arn}"
    spot_price = "0.0044"
    target_capacity = 0
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
    #depends_on = ["aws_iam_policy_attachment.test-attach"]
}