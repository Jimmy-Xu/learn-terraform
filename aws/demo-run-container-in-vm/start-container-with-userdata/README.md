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
```