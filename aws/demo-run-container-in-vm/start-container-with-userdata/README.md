run container in vm
----------------------------

- start aws EC2 Instance with userdata
- pull docker image
- run docker container

Set VPC_ID and KP in variables.tf first.

<!-- TOC -->

- [Usage](#usage)
    - [init](#init)
    - [plan](#plan)
    - [apply](#apply)
    - [output](#output)
    - [change userdata](#change-userdata)
- [access nginx container](#access-nginx-container)
- [ssh into EC2 Instance](#ssh-into-ec2-instance)
    - [enter EC2 Instance](#enter-ec2-instance)
    - [execute command via ssh](#execute-command-via-ssh)

<!-- /TOC -->

# Usage

## init

```
terraform init
```

## plan
```
$ terraform plan
```

## apply

```
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

## output

```
$ terraform output
ContainerVM_ip = [
    54.255.169.38
]
SG_id = sg-4435833c
SUBNET_id = [
    subnet-bec7fbf7
]
VPC_id = vpc-b41843d3
```

## change userdata

- old EC2 Instance will be destroyed
- new EC2 Instance will be created

```
$ time terraform apply
data.aws_vpc.VPC: Refreshing state...
data.aws_subnet_ids.ALL_SUBNET: Refreshing state...
data.aws_security_group.SG: Refreshing state...
data.aws_subnet.PUBLIC_SUBNET: Refreshing state...
aws_instance.ContainerVM: Refreshing state... (ID: i-0f4d1b5e6c39b28fd)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

-/+ aws_instance.ContainerVM (new resource required)
      id:                                "i-0f4d1b5e6c39b28fd" => <computed> (forces new resource)
      ami:                               "ami-ff084815" => "ami-ff084815"
      associate_public_ip_address:       "true" => "true"
      availability_zone:                 "ap-southeast-1a" => <computed>
      cpu_core_count:                    "1" => <computed>
      cpu_threads_per_core:              "1" => <computed>
      ebs_block_device.#:                "0" => <computed>
      ephemeral_block_device.#:          "0" => <computed>
      get_password_data:                 "false" => "false"
      instance_state:                    "running" => <computed>
      instance_type:                     "t2.nano" => "t2.nano"
      ipv6_address_count:                "" => <computed>
      ipv6_addresses.#:                  "0" => <computed>
      key_name:                          "test-terraform" => "test-terraform"
      network_interface.#:               "0" => <computed>
      network_interface_id:              "eni-1364a03e" => <computed>
      password_data:                     "" => <computed>
      placement_group:                   "" => <computed>
      primary_network_interface_id:      "eni-1364a03e" => <computed>
      private_dns:                       "ip-172-28-0-174.ap-southeast-1.compute.internal" => <computed>
      private_ip:                        "172.28.0.174" => <computed>
      public_dns:                        "ec2-13-228-29-184.ap-southeast-1.compute.amazonaws.com" => <computed>
      public_ip:                         "13.228.29.184" => <computed>
      root_block_device.#:               "1" => <computed>
      security_groups.#:                 "0" => <computed>
      source_dest_check:                 "true" => "true"
      subnet_id:                         "subnet-bec7fbf7" => "subnet-bec7fbf7"
      tags.%:                            "1" => "1"
      tags.Name:                         "demo-run-container-in-vm-ContainerVM" => "demo-run-container-in-vm-ContainerVM"
      tenancy:                           "default" => <computed>
      user_data:                         "61dec998cd69362e38becb6011d0cc384a579768" => "2342012c10e54628c85c336823ffd6dfea1ac3af" (forces new resource)
      volume_tags.%:                     "0" => <computed>
      vpc_security_group_ids.#:          "1" => "1"
      vpc_security_group_ids.3374628741: "sg-4435833c" => "sg-4435833c"


Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.ContainerVM: Destroying... (ID: i-0f4d1b5e6c39b28fd)
aws_instance.ContainerVM: Still destroying... (ID: i-0f4d1b5e6c39b28fd, 10s elapsed)
aws_instance.ContainerVM: Still destroying... (ID: i-0f4d1b5e6c39b28fd, 20s elapsed)
aws_instance.ContainerVM: Destruction complete after 26s
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
  user_data:                         "" => "2342012c10e54628c85c336823ffd6dfea1ac3af"
  volume_tags.%:                     "" => "<computed>"
  vpc_security_group_ids.#:          "" => "1"
  vpc_security_group_ids.3374628741: "" => "sg-4435833c"
aws_instance.ContainerVM: Still creating... (10s elapsed)
aws_instance.ContainerVM: Still creating... (20s elapsed)
aws_instance.ContainerVM: Creation complete after 26s (ID: i-0cca86547a5ee460e)

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

ContainerVM_ip = [
    54.169.24.159
]
SG_id = sg-4435833c
SUBNET_id = [
    subnet-bec7fbf7
]
VPC_id = vpc-b41843d3
terraform apply  0.97s user 0.45s system 1% cpu 1:30.14 total
```

# access nginx container

```
curl -s http://54.169.24.159 | grep title
<title>Welcome to nginx!</title>
```


# ssh into EC2 Instance

## enter EC2 Instance

```
$ ssh -i ~/.ssh/test-terraform.pem core@54.169.24.159
The authenticity of host '54.169.24.159 (54.169.24.159)' can't be established.
ECDSA key fingerprint is SHA256:WjT0wxjVGfhwxg1N74V7c4jUjygloXiqPH9N5pWzxeI.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '54.169.24.159' (ECDSA) to the list of known hosts.
Container Linux by CoreOS stable (1800.5.0)
core@ip-172-28-0-174 ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                NAMES
13140671ffa8        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   gallant_beaver
```

## execute command via ssh

```
$ ssh -i ~/.ssh/test-terraform.pem core@54.169.24.159 "docker ps"
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
13140671ffa8        nginx               "nginx -g 'daemon of…"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   gallant_beaver
```
