run container in vm
----------------------------

- start aws EC2 Instance with userdata

Set VPC_ID and KP in variables.tf first.

# create

```
$ date; time terraform apply -var=PROJECT_NAME=demo --refresh=false -auto-approve
2018年 8月21日 星期二 12时52分31秒 CST
aws_security_group.SG: Creating...
  arn:                                   "" => "<computed>"
  description:                           "" => "Managed by Terraform"
  egress.#:                              "" => "1"
  egress.482069346.cidr_blocks.#:        "" => "1"
  egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
  egress.482069346.description:          "" => ""
  egress.482069346.from_port:            "" => "0"
  egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
  egress.482069346.prefix_list_ids.#:    "" => "0"
  egress.482069346.protocol:             "" => "-1"
  egress.482069346.security_groups.#:    "" => "0"
  egress.482069346.self:                 "" => "false"
  egress.482069346.to_port:              "" => "0"
  ingress.#:                             "" => "1"
  ingress.2541437006.cidr_blocks.#:      "" => "1"
  ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2541437006.description:        "" => ""
  ingress.2541437006.from_port:          "" => "22"
  ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"
  ingress.2541437006.protocol:           "" => "tcp"
  ingress.2541437006.security_groups.#:  "" => "0"
  ingress.2541437006.self:               "" => "false"
  ingress.2541437006.to_port:            "" => "22"
  name:                                  "" => "SG-alpine"
  owner_id:                              "" => "<computed>"
  revoke_rules_on_delete:                "" => "false"
  tags.%:                                "" => "1"
  tags.Name:                             "" => "demo-SG-alpine"
  vpc_id:                                "" => "vpc-02875a69a070c60d1"
aws_security_group.SG: Still creating... (10s elapsed)
aws_security_group.SG: Creation complete after 12s (ID: sg-0470c09cccd5d6c8b)
aws_instance.AlpineVM: Creating...
  ami:                               "" => "ami-976020ed"
  associate_public_ip_address:       "" => "true"
  availability_zone:                 "" => "<computed>"
  cpu_core_count:                    "" => "<computed>"
  cpu_threads_per_core:              "" => "<computed>"
  ebs_block_device.#:                "" => "<computed>"
  ephemeral_block_device.#:          "" => "<computed>"
  get_password_data:                 "" => "false"
  instance_state:                    "" => "<computed>"
  instance_type:                     "" => "t2.nano"
  ipv6_address_count:                "" => "<computed>"
  ipv6_addresses.#:                  "" => "<computed>"
  key_name:                          "" => "demo-kp"
  network_interface.#:               "" => "<computed>"
  network_interface_id:              "" => "<computed>"
  password_data:                     "" => "<computed>"
  placement_group:                   "" => "<computed>"
  primary_network_interface_id:      "" => "<computed>"
  private_dns:                       "" => "<computed>"
  private_ip:                        "" => "<computed>"
  public_dns:                        "" => "<computed>"
  public_ip:                         "" => "<computed>"
  root_block_device.#:               "" => "<computed>"
  security_groups.#:                 "" => "<computed>"
  source_dest_check:                 "" => "true"
  subnet_id:                         "" => "subnet-059fa6d4f1d5571cd"
  tags.%:                            "" => "1"
  tags.Name:                         "" => "demo-AlpineVM"
  tenancy:                           "" => "<computed>"
  user_data:                         "" => "ec9da7ab934b7c9d37ab6367bdeb11d7704f7745"
  volume_tags.%:                     "" => "<computed>"
  vpc_security_group_ids.#:          "" => "1"
  vpc_security_group_ids.2569646822: "" => "sg-0470c09cccd5d6c8b"
aws_instance.AlpineVM: Still creating... (10s elapsed)
aws_instance.AlpineVM: Still creating... (20s elapsed)
aws_instance.AlpineVM: Creation complete after 29s (ID: i-0ce0d0732cd8ce2a8)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

AlpineVM_ip = [
    18.212.150.110
]
SG_id = sg-0470c09cccd5d6c8b
SUBNET_id = [
    subnet-059fa6d4f1d5571cd,
    subnet-005cc701bf06930ca
]
VPC_id = vpc-02875a69a070c60d1
terraform apply -var=PROJECT_NAME=demo --refresh=false -auto-approve  0.89s user 0.38s system 2% cpu 51.663 total
```