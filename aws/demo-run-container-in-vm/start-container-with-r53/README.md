test with Spot Fleet + CloudWatch + Lambda + R53
------------------------------------------------

# required permission
```
AmazonEC2FullAccess
AWSLambdaFullAccess
AmazonVPCFullAccess
AmazonRoute53FullAccess
IAMFullAccess
```

# dependency

```
$ sudo pip install botocore==1.10.67 boto3==1.7.67
```

# step
```
$ terraform init

$ terraform plan -var=PROJECT_NAME=demo

$ terraform apply -auto-approve -var=PROJECT_NAME=demo

$ terraform refresh -var=PROJECT_NAME=demo

$ ssh -i ~/.ssh/test-terraform.pem -o "StrictHostKeyChecking=no" core@52.77.210.111
```