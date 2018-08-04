# Bash CLI
**A command line framework built using nothing but Bash and compatible with anything**

REF: https://github.com/SierraSoftworks/bash-cli

## create command
```
//create a soft link /usr/local/bin/my-pi
$ sudo ./cli install my-pi

//create customized command
$ ./cli command create project create
$ ./cli command create project delete
$ ./cli command create run
```

## define command

- app/project/create
- app/project/delete
- app/run

## use command

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
 terraform destroy -auto-approve -var PROJECT_NAME=demo sucessed.
duration: 109 (seconds)
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