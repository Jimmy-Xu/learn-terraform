test with spot fleet
----------------------

```
$ terraform plan -var=PROJECT_NAME=demo

$ terraform apply -auto-approve -var=PROJECT_NAME=demo

$ terraform refresh -var=PROJECT_NAME=demo
data.template_file.CERT_SERVER: Refreshing state...
data.template_file.CERT_CA: Refreshing state...
data.template_file.CERT_SERVER_KEY: Refreshing state...
data.aws_vpc.VPC: Refreshing state...
data.aws_iam_role.IAM_ROLE: Refreshing state...
data.aws_instances.SPOT_FLEET_INSTANCE_IPS: Refreshing state...
aws_security_group.SG: Refreshing state... (ID: sg-05aef373aa826f5dc)
data.aws_subnet_ids.ALL_SUBNET: Refreshing state...
data.aws_subnet.PUBLIC_SUBNET: Refreshing state...
aws_launch_template.LAUNCH_TEMPLATE: Refreshing state... (ID: lt-00c4281fbc8ffe497)
aws_spot_fleet_request.SPOT_FLEET_REQUEST: Refreshing state... (ID: sfr-bd85eed8-fe35-49d5-8e57-30bf94d340e9)

Outputs:

LT_id = lt-00c4281fbc8ffe497
SFR_id = sfr-bd85eed8-fe35-49d5-8e57-30bf94d340e9
SG_id = sg-05aef373aa826f5dc
SPOT_INSTANCE_PRIVATE_IPS = [
    172.28.0.123
]
SPOT_INSTANCE_PUBLIC_IDS = [
    i-0ba49e7785d8cdb2d
]
SPOT_INSTANCE_PUBLIC_IPS = [
    52.77.210.111
]
SUBNET_id = [
    subnet-90e7d8d9
]
VPC_id = vpc-1e431979

$ ssh -i ~/.ssh/test-terraform.pem -o "StrictHostKeyChecking=no" core@52.77.210.111
```