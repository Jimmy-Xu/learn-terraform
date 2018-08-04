Bash CLI
--------------

**A command line framework built using nothing but Bash and compatible with anything**

REF: https://github.com/SierraSoftworks/bash-cli

<!-- TOC -->

- [Bash CLI](#bash-cli)
- [create command](#create-command)
- [define command](#define-command)
- [usage](#usage)
    - [create project](#create-project)
    - [delete project](#delete-project)
    - [run container](#run-container)
    - [rm container](#rm-container)

<!-- /TOC -->

## create command
```
//create a soft link /usr/local/bin/my-pi
$ sudo ./cli install my-pi

//create customized command
$ ./cli command create project create
$ ./cli command create project delete
$ ./cli command create run
$ ./cli command create rm
```

## define command

- app/project/create
- app/project/delete
- app/run
- app/rm

## usage

### create project
```
$ my-pi project create --type aws demo
Start to create project 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 9 (seconds)
 terraform apply -auto-approve -refresh=false -var PROJECT_NAME=demo sucessed.
apply duration: 115 (seconds)
```

### delete project
```
$ my-pi project delete --type aws demo
Start to delete project 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 31 (seconds)
 terraform destroy -auto-approve -refresh=false -var PROJECT_NAME=demo sucessed.
destroy duration: 62 (seconds)
```

### run container
```
$ my-pi run --type aws demo
Start to run container 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 18 (seconds)
 terraform apply -auto-approve refresh=false -var PROJECT_NAME=demo sucessed.
apply duration: 77 (seconds)
```

### rm container
```
$ my-pi rm --type aws demo
Start to rm container 'demo' in cloud 'aws'
 terraform refresh -var PROJECT_NAME=demo sucessed.
refresh duration: 33 (seconds)
 terraform destroy -auto-approve refresh=false -var PROJECT_NAME=demo sucessed.
destroy duration: 73 (seconds)
```