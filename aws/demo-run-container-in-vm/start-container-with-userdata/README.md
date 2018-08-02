run container in vm
----------------------------

- start aws EC2 Instance with userdata
- pull docker image
- run docker container

Set VPC_ID and KP in variables.tf first.

# Usage

```
$ terraform init

$ terraform plan

$ terraform apply
time terraform apply
data.aws_vpc.VPC: Refreshing state...
data.aws_subnet_ids.ALL_SUBNET: Refreshing state...
data.aws_security_group.SG: Refreshing state...
data.aws_subnet.PUBLIC_SUBNET: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.ContainerVM
      id:                                <computed>
      ami:                               "ami-ff084815"
      associate_public_ip_address:       "true"
      availability_zone:                 <computed>
      cpu_core_count:                    <computed>
      cpu_threads_per_core:              <computed>
      ebs_block_device.#:                <computed>
      ephemeral_block_device.#:          <computed>
      get_password_data:                 "false"
      instance_state:                    <computed>
      instance_type:                     "t2.nano"
      ipv6_address_count:                <computed>
      ipv6_addresses.#:                  <computed>
      key_name:                          "test-terraform"
      network_interface.#:               <computed>
      network_interface_id:              <computed>
      password_data:                     <computed>
      placement_group:                   <computed>
      primary_network_interface_id:      <computed>
      private_dns:                       <computed>
      private_ip:                        <computed>
      public_dns:                        <computed>
      public_ip:                         <computed>
      root_block_device.#:               <computed>
      security_groups.#:                 <computed>
      source_dest_check:                 "true"
      subnet_id:                         "subnet-bec7fbf7"
      tags.%:                            "1"
      tags.Name:                         "demo-run-container-in-vm-ContainerVM"
      tenancy:                           <computed>
      user_data:                         "67eabbc50d3e6f5608ddc8d086628b460a95ccdc"
      volume_tags.%:                     <computed>
      vpc_security_group_ids.#:          "1"
      vpc_security_group_ids.3374628741: "sg-4435833c"


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.ContainerVM: Creating...
  ami:                               "" => "ami-ff084815"
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
  key_name:                          "" => "test-terraform"
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
  subnet_id:                         "" => "subnet-bec7fbf7"
  tags.%:                            "" => "1"
  tags.Name:                         "" => "demo-run-container-in-vm-ContainerVM"
  tenancy:                           "" => "<computed>"
  user_data:                         "" => "67eabbc50d3e6f5608ddc8d086628b460a95ccdc"
  volume_tags.%:                     "" => "<computed>"
  vpc_security_group_ids.#:          "" => "1"
  vpc_security_group_ids.3374628741: "" => "sg-4435833c"
aws_instance.ContainerVM: Still creating... (10s elapsed)
aws_instance.ContainerVM: Still creating... (20s elapsed)
aws_instance.ContainerVM: Still creating... (30s elapsed)
aws_instance.ContainerVM: Creation complete after 36s (ID: i-053e527ff9718a1f1)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ContainerVM_ip = [
    54.255.169.38
]
SG_id = sg-4435833c
SUBNET_id = [
    subnet-bec7fbf7
]
VPC_id = vpc-b41843d3
terraform apply  0.87s user 0.37s system 1% cpu 1:15.75 total
```