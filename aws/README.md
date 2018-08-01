Terraform learning
------------------------

# AWS

## Reference

- https://www.terraform.io/docs/providers/aws

## Dependency

- awscli
- terraform

## Install cli

```
$ brew install terraform
$ brew install awscli
```

## Config aws credential

### aws iam user

```
//create a new iam user "ecs-test" with the following permission
IAMFullAccess
AmazonEC2ContainerRegistryFullAccess
AmazonS3FullAccess
AmazonEC2ReadOnlyAccess
AmazonECS_FullAccess
AmazonVPCFullAccess
AWSCertificateManagerFullAccess

//save the credentials
```

### config awscli

```
//add a new profile ecs-test with the above credentials
$ aws --profile ecs-test configure
```

## user proxy

```
//for terraform
$ export http_proxy=http://127.0.0.1:8118

//for awscli, use s3-proxy
$ /usr/local/opt/awscli/libexec/bin/pip install awscli-plugin-s3-proxy
$ aws configure set plugins.s3-proxy awscli_plugin_s3_proxy
$ aws configure --profile ecs-test set s3.proxy http://127.0.0.1:8118
$ aws --profile=ecs-test s3 ls
Using S3 proxy: http://127.0.0.1:8118
2015-06-08 20:07:34 xxxxxx
...
```
