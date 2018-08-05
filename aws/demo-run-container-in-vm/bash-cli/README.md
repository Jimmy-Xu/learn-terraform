Bash CLI
--------------

**A command line framework built using nothing but Bash and compatible with anything**

REF: https://github.com/SierraSoftworks/bash-cli

<!-- TOC -->

- [create command](#create-command)
- [define command](#define-command)
- [usage](#usage)
    - [project operation](#project-operation)
        - [create project](#create-project)
        - [refresh project](#refresh-project)
        - [get project](#get-project)
        - [delete project](#delete-project)
    - [container operation](#container-operation)
        - [run container](#run-container)
        - [refresh container](#refresh-container)
        - [get container](#get-container)
        - [rm container](#rm-container)

<!-- /TOC -->

# create command
```
//create a soft link /usr/local/bin/my-pi
$ sudo ./cli install my-pi

//create customized command
$ ./cli command create project create
$ ./cli command create project refresh
$ ./cli command create project get
$ ./cli command create project delete

$ ./cli command create run
$ ./cli command create refresh
$ ./cli command create get
$ ./cli command create rm
```

# define command

- app/project/create
- app/project/get
- app/project/refresh
- app/project/delete
- app/run
- app/refresh
- app/get
- app/rm

# usage

## project operation

AWS resources: VPC,DHCPOPtion,Subnet,IGW,RouteTable,NetworkAcl

### create project
```
$ my-pi project create --type aws demo
Start to create project 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
 terraform apply -auto-approve -refresh=false -var PROJECT_NAME=demo sucessed.
apply duration: 87 (seconds)
```

### refresh project
```
$ my-pi project refresh --type aws demo
Start to refresh project 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 52 (seconds)
```

### get project
```
$ my-pi project get --type aws demo
Start to get project 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
==============================
project_name = demo
vpc_id = vpc-1e431979
==============================
```

### delete project
```
$ my-pi project delete --type aws demo
Start to delete project 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
 terraform destroy -auto-approve -refresh=false -var PROJECT_NAME=demo sucessed.
destroy duration: 46 (seconds)
```

## container operation

AWS resources: EC2 Instance, SG

### run container
```
$ my-pi run --type aws demo
Start to run container 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
 terraform apply -auto-approve refresh=false -var PROJECT_NAME=demo sucessed.
apply duration: 87 (seconds)
```

### refresh container
```
$ my-pi refresh --type aws demo
Start to refresh container 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 23 (seconds)
```

### get container
```
$ my-pi get --type aws demo
Start to get container 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
==============================
ContainerVM_ip = [
    52.221.251.21
]
SG_id = sg-a1c57ad9
SUBNET_id = [
    subnet-90e7d8d9
]
VPC_id = vpc-1e431979
==============================
```

### rm container
```
$ my-pi rm --type aws demo
Start to rm container 'demo' in cloud 'aws'
<skip refresh dure to without --refresh>
 terraform destroy -auto-approve refresh=false -var PROJECT_NAME=demo sucessed.
destroy duration: 57 (seconds)
```