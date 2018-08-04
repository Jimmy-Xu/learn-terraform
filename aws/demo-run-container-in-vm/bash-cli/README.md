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
```

## define command

- app/project/create
- app/project/delete

## use command

```
$ my-pi project create --type aws demo
Start to create project 'demo' in cloud 'aws'
 terraform apply -auto-approve -var PROJECT_NAME=demo sucessed.
duration: 113 (seconds)

$ my-pi project delete --type aws demo
Start to delete project 'demo' in cloud 'aws'
 terraform destroy -auto-approve -var PROJECT_NAME=demo sucessed.
duration: 109 (seconds)

```