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

# get aws info

## get all regions

```
$ aws --profile ecs-test ec2 describe-regions --output text | awk '{print $NF}'

REGIONS ec2.ap-south-1.amazonaws.com    ap-south-1
REGIONS ec2.eu-west-3.amazonaws.com     eu-west-3
REGIONS ec2.eu-west-2.amazonaws.com     eu-west-2
REGIONS ec2.eu-west-1.amazonaws.com     eu-west-1
REGIONS ec2.ap-northeast-2.amazonaws.com        ap-northeast-2
REGIONS ec2.ap-northeast-1.amazonaws.com        ap-northeast-1
REGIONS ec2.sa-east-1.amazonaws.com     sa-east-1
REGIONS ec2.ca-central-1.amazonaws.com  ca-central-1
REGIONS ec2.ap-southeast-1.amazonaws.com        ap-southeast-1
REGIONS ec2.ap-southeast-2.amazonaws.com        ap-southeast-2
REGIONS ec2.eu-central-1.amazonaws.com  eu-central-1
REGIONS ec2.us-east-1.amazonaws.com     us-east-1
REGIONS ec2.us-east-2.amazonaws.com     us-east-2
REGIONS ec2.us-west-1.amazonaws.com     us-west-1
REGIONS ec2.us-west-2.amazonaws.com     us-west-2
```

## get spot instance price of a instance_type

```
$ aws --profile ecs-test --region ap-southeast-1 ec2 describe-spot-price-history \
  --filters Name=product-description,Values="Linux/UNIX" \
  --start-time 2018-08-16T00:00:00 \
  --instance-types t2.micro \
  --output=text

SPOTPRICEHISTORY        ap-southeast-1c t2.micro        Linux/UNIX      0.004400        2018-08-15T14:19:34.000Z
SPOTPRICEHISTORY        ap-southeast-1a t2.micro        Linux/UNIX      0.004400        2018-08-15T14:19:34.000Z
SPOTPRICEHISTORY        ap-southeast-1b t2.micro        Linux/UNIX      0.004400        2018-08-15T14:19:34.000Z
```

## get spot instance price in all region

```
$ for r in $(aws --profile ecs-test ec2 describe-regions --output text | awk '{print $NF}')
do
  aws --profile ecs-test --region $r ec2 describe-spot-price-history \
  --filters Name=product-description,Values="Linux/UNIX" \
  --start-time 2018-08-16T00:00:00 \
  --instance-types t2.micro \
  --output=text | head -n1 | awk '{printf "%s\t%s\n",$2,$5}'
done | sort -k2 -n

us-east-1b      0.003500
us-east-2c      0.003500
us-west-2c      0.003500
ca-central-1b   0.003800
eu-west-1a      0.003800
eu-central-1b   0.004000
eu-west-2b      0.004000
eu-west-3c      0.004000
us-west-1c      0.004100
ap-northeast-2c 0.004300
ap-south-1b     0.004300
ap-southeast-1c 0.004400
ap-southeast-2a 0.004400
ap-northeast-1a 0.004600
sa-east-1c      0.005600
```

## get price for on-demand instance

https://www.ec2instances.info/?filter=t2&cost_duration=hourly&reserved_term=yrTerm1Standard.noUpfront&region=ap-southeast-1


# step
```
$ terraform init

$ terraform plan -var=PROJECT_NAME=demo

$ terraform apply -auto-approve -var=PROJECT_NAME=demo

$ terraform refresh -var=PROJECT_NAME=demo

$ ssh -i ~/.ssh/test-terraform.pem -o "StrictHostKeyChecking=no" core@52.77.210.111
```