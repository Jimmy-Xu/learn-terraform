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
- [Access](#access)
    - [access nginx container](#access-nginx-container)
    - [access EC2 Instance](#access-ec2-instance)
    - [access remote docker from local](#access-remote-docker-from-local)
- [Destroy](#destroy)

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
$ terraform destroy
data.aws_vpc.VPC: Refreshing state...
data.aws_subnet_ids.ALL_SUBNET: Refreshing state...
data.aws_security_group.SG: Refreshing state...
data.aws_subnet.PUBLIC_SUBNET: Refreshing state...
aws_instance.ContainerVM: Refreshing state... (ID: i-0e2cb58cacc9009c9)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_instance.ContainerVM


Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.ContainerVM: Destroying... (ID: i-0e2cb58cacc9009c9)
aws_instance.ContainerVM: Still destroying... (ID: i-0e2cb58cacc9009c9, 10s elapsed)
aws_instance.ContainerVM: Still destroying... (ID: i-0e2cb58cacc9009c9, 20s elapsed)
aws_instance.ContainerVM: Destruction complete after 24s

Destroy complete! Resources: 1 destroyed.
```

# Access

## access nginx container

```
$ curl -s http://13.250.28.135 | grep title
<title>Welcome to nginx!</title>
```


## access EC2 Instance

ssh into EC2 Instance
```

$ ssh -i ~/.ssh/test-terraform.pem -o "StrictHostKeyChecking=no" core@13.250.28.135
Warning: Permanently added '13.250.28.135' (ECDSA) to the list of known hosts.
Last login: Fri Aug  3 04:13:03 UTC 2018 from 123.122.16.99 on pts/0
Container Linux by CoreOS stable (1800.5.0)

core@ip-172-28-0-174 ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                NAMES
13140671ffa8        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   gallant_beaver
```


execute command in EC2 Instance via ssh
```
$ ssh -i ~/.ssh/test-terraform.pem -o "StrictHostKeyChecking=no" core@13.250.28.135 "docker ps"
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
13140671ffa8        nginx               "nginx -g 'daemon of…"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   gallant_beaver
```

## access remote docker from local

```
$ docker -H tcp://13.250.28.135:2375 ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
3f47ef370395        nginx               "nginx -g 'daemon of…"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   elegant_sammet
```


# Destroy

the EC2 Instance will be terminated.

```
$ terraform destroy
data.aws_vpc.VPC: Refreshing state...
data.aws_subnet_ids.ALL_SUBNET: Refreshing state...
data.aws_security_group.SG: Refreshing state...
data.aws_subnet.PUBLIC_SUBNET: Refreshing state...
aws_instance.ContainerVM: Refreshing state... (ID: i-0e2cb58cacc9009c9)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_instance.ContainerVM


Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.ContainerVM: Destroying... (ID: i-0e2cb58cacc9009c9)
aws_instance.ContainerVM: Still destroying... (ID: i-0e2cb58cacc9009c9, 10s elapsed)
aws_instance.ContainerVM: Still destroying... (ID: i-0e2cb58cacc9009c9, 20s elapsed)
aws_instance.ContainerVM: Destruction complete after 24s

Destroy complete! Resources: 1 destroyed.
```