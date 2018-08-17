test with Spot Fleet + CloudWatch + Lambda + R53
------------------------------------------------

<!-- TOC -->

- [prepare](#prepare)
    - [required permission](#required-permission)
    - [install dependency](#install-dependency)
    - [build pr of terraform-provider-aws](#build-pr-of-terraform-provider-aws)
- [run with terraform](#run-with-terraform)
- [get info](#get-info)
- [remote access](#remote-access)
    - [ssh connect to EC2 Instance](#ssh-connect-to-ec2-instance)
    - [execute docker ps](#execute-docker-ps)
    - [enter container](#enter-container)
    - [memory usage](#memory-usage)
- [get aws info](#get-aws-info)
    - [get all regions](#get-all-regions)
    - [get spot instance price of a instance_type](#get-spot-instance-price-of-a-instancetype)
    - [get spot instance price in all region](#get-spot-instance-price-in-all-region)
    - [get price for on-demand instance](#get-price-for-on-demand-instance)
- [FAQ](#faq)
    - [about update target_capacity for spot_fleet_request](#about-update-targetcapacity-for-spotfleetrequest)
    - [time duration after set target_capacity from 1 to 0](#time-duration-after-set-targetcapacity-from-1-to-0)

<!-- /TOC -->

# prepare

## required permission
```
AmazonEC2FullAccess
AWSLambdaFullAccess
AmazonVPCFullAccess
AmazonRoute53FullAccess
IAMFullAccess
```

## install dependency

> for write lambda
```
$ sudo pip install botocore==1.10.67 boto3==1.7.67 awscli=1.15.68
```

## build pr of terraform-provider-aws

> for suport on_demand_target_capacity in aws_spot_fleet_request, 
https://github.com/terraform-providers/terraform-provider-aws/pull/4866

```
$ mkdir -p $GOPATH/src/github.com/terraform-providers
$ cd $GOPATH/src/github.com/terraform-providers
$ git clone https://github.com/terraform-providers/terraform-provider-aws.git
$ git checkout pr/4866
$ make build
```


# run with terraform
```
//replace terraform-provider-aws
$ terraform init
$ GOHOSTOS=$(go env GOHOSTOS)
$ GOARCH=$(go env GOARCH)
$ ls .terraform/plugins/${GOHOSTOS}_${GOARCH}/*aws*
.terraform/plugins/darwin_amd64/terraform-provider-aws_v1.31.0_x4
$ cp $GOPATH/bin/terraform-provider-aws .terraform/plugins/darwin_amd64/terraform-provider-aws_v1.31.0_x4

//init again
$ terraform init

//diff
$ terraform plan -var=PROJECT_NAME=demo

//create resource
$ terraform apply -auto-approve -var=PROJECT_NAME=demo

//refresh resource info
$ terraform refresh -var=PROJECT_NAME=demo

//delete all resource
$ terraform destroy -var=PROJECT_NAME=demo
```

# get info

```
$ terraform output
LT_id = lt-01756df37370050f0
SFR_id = sfr-2983a145-90d0-4fef-8c9e-360cf487b876
SG_id = sg-0c9fe4e5081979592
SPOT_INSTANCE_PRIVATE_IPS = [
    172.28.0.144
]
SPOT_INSTANCE_PUBLIC_IDS = [
    i-0d1e0e964e9d995bc
]
SPOT_INSTANCE_PUBLIC_IPS = [
    54.91.193.152
]
SUBNET_id = [
    subnet-09d07988d4b160129
]
VPC_id = vpc-0c3b994952fa617da
```

# remote access

## ssh connect to EC2 Instance
```
$ ssh -i ~/.ssh/demo -o "StrictHostKeyChecking=no" core@54.91.193.152
Last login: Fri Aug 17 02:53:18 UTC 2018 from 123.116.140.17 on pts/0
Container Linux by CoreOS stable (1800.5.0)
core@ip-172-28-0-144 ~ $ exit
Connection to 54.91.193.152 closed.
```

## execute docker ps
```
$ ssh -i ~/.ssh/demo core@54.91.193.152 "docker ps"
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
b751e907c3f4        nginx               "nginx -g 'daemon of…"   6 minutes ago       Up 6 minutes        0.0.0.0:80->80/tcp   eloquent_swanson
```

## enter container

> use `-t` of ssh

```
$ ssh -i ~/.ssh/demo -t core@54.91.193.152 "docker exec -it b75 bash"
root@b751e907c3f4:/# ls
bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
boot  etc  lib   media  opt  root  sbin  sys  usr
root@b751e907c3f4:/# exit
exit
Connection to 54.91.193.152 closed.
```

## memory usage

```
$ ssh -i ~/.ssh/demo -t core@54.91.193.152 "ps -e -o 'pid,comm,pcpu,rsz,vsz,stime,user,uid' | sort -k4 -n -r"
  PID COMMAND         %CPU   RSZ    VSZ STIME USER       UID
  863 dockerd          0.2 73368 547056 02:42 root         0
  827 containerd       0.1 25256 227024 02:42 root         0
  768 update_engine    0.0 16380 262032 02:42 root         0
  809 polkitd          0.0 15496 393768 02:42 polkitd    235
    1 systemd          0.1 10152 151764 02:41 root         0
  618 systemd-journal  0.0  8968  72132 02:41 root         0
  804 locksmithd       0.0  8212  51076 02:42 root         0
  658 systemd-udevd    0.0  7872  73692 02:42 root         0
 1692 systemd          1.0  7492  68364 03:15 core       500
  755 systemd-logind   0.0  7260  58548 02:42 root         0
  659 systemd-network  0.0  7064  68672 02:42 systemd+   244
 1690 sshd             0.0  6588  83044 03:15 root         0
 1688 sshd             0.0  6208  78412 03:15 root         0
  726 systemd-resolve  0.0  6168  60848 02:42 systemd+   245
  716 systemd-timesyn  0.0  5816 137680 02:42 systemd+ 62583
 1040 nginx            0.0  5192  32624 02:42 root         0
  773 dbus-daemon      0.0  4840  65300 02:42 message+   201
 1025 containerd-shim  0.0  4180   7664 02:42 root         0
 1700 ps               0.0  3468  46008 03:15 core       500
 1067 nginx            0.0  3124  33076 02:42 101        101
 1698 sshd             0.0  3068  83044 03:15 core       500
 1019 docker-proxy     0.0  2916  42836 02:42 root         0
 1689 sshd             0.0  2876  40664 03:15 sshd       204
 1699 bash             0.0  2796   9992 03:15 core       500
 1693 (sd-pam)         0.0  2232 181920 03:15 core       500
  853 agetty           0.0  1952  10780 02:42 root         0
  854 agetty           0.0  1808  12676 02:42 root         0
 1701 sort             0.0   928  12892 03:15 core       500
 1484 kworker/0:6      0.0     0      0 03:09 root         0
 1462 kworker/0:4      0.0     0      0 03:09 root         0
 1459 kworker/0:3      0.0     0      0 03:09 root         0
 1454 kworker/0:2      0.0     0      0 03:09 root         0
 1449 kworker/0:1      0.0     0      0 03:08 root         0
 1127 kworker/0:5      0.0     0      0 02:46 root         0
  704 ext4-rsv-conver  0.0     0      0 02:42 root         0
  703 jbd2/xvda6-8     0.0     0      0 02:42 root         0
  683 edac-poller      0.0     0      0 02:42 root         0
  455 ext4-rsv-conver  0.0     0      0 02:41 root         0
  452 ext4-rsv-conver  0.0     0      0 02:41 root         0
  451 jbd2/xvda9-8     0.0     0      0 02:41 root         0
  436 bioset           0.0     0      0 02:41 root         0
  435 kverityd         0.0     0      0 02:41 root         0
  432 bioset           0.0     0      0 02:41 root         0
  431 dm_bufio_cache   0.0     0      0 02:41 root         0
  427 kdmflush         0.0     0      0 02:41 root         0
  314 scsi_tmf_1       0.0     0      0 02:41 root         0
  312 scsi_eh_1        0.0     0      0 02:41 root         0
  309 scsi_tmf_0       0.0     0      0 02:41 root         0
  306 scsi_eh_0        0.0     0      0 02:41 root         0
  303 kworker/0:1H     0.0     0      0 02:41 root         0
  301 ata_sff          0.0     0      0 02:41 root         0
   44 kworker/u30:1    0.0     0      0 02:41 root         0
   43 ipv6_addrconf    0.0     0      0 02:41 root         0
   42 acpi_thermal_pm  0.0     0      0 02:41 root         0
   41 kthrotld         0.0     0      0 02:41 root         0
   29 kswapd0          0.0     0      0 02:41 root         0
   28 kauditd          0.0     0      0 02:41 root         0
   27 watchdogd        0.0     0      0 02:41 root         0
   26 kblockd          0.0     0      0 02:41 root         0
   25 kintegrityd      0.0     0      0 02:41 root         0
   24 crypto           0.0     0      0 02:41 root         0
   23 khugepaged       0.0     0      0 02:41 root         0
   22 ksmd             0.0     0      0 02:41 root         0
   21 kcompactd0       0.0     0      0 02:41 root         0
   20 writeback        0.0     0      0 02:41 root         0
   19 oom_reaper       0.0     0      0 02:41 root         0
   18 khungtaskd       0.0     0      0 02:41 root         0
   16 xenwatch         0.0     0      0 02:41 root         0
   15 xenbus           0.0     0      0 02:41 root         0
   14 netns            0.0     0      0 02:41 root         0
   13 kdevtmpfs        0.0     0      0 02:41 root         0
   12 cpuhp/0          0.0     0      0 02:41 root         0
   11 watchdog/0       0.0     0      0 02:41 root         0
   10 migration/0      0.0     0      0 02:41 root         0
    9 rcu_bh           0.0     0      0 02:41 root         0
    8 rcu_sched        0.0     0      0 02:41 root         0
    7 ksoftirqd/0      0.0     0      0 02:41 root         0
    6 mm_percpu_wq     0.0     0      0 02:41 root         0
    5 kworker/u30:0    0.0     0      0 02:41 root         0
    4 kworker/0:0H     0.0     0      0 02:41 root         0
    2 kthreadd         0.0     0      0 02:41 root         0
Connection to 54.91.193.152 closed.
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

# FAQ

## about update target_capacity for spot_fleet_request

update target_capacity from 1 to 0 is invalid, terraform apply return ok, but target_capacity is still 1.


## time duration after set target_capacity from 1 to 0

- update target_capacity from 1 to 0 via aws console
- 2min+ was required to terminate an instance in spot fleet

```
> Spot Fleet Request: 8/17/2018, 12:03:03 PM targetCapacity from 1 to 0

> Spot Fleet Request: 8/17/2018, 12:04:15 PM termination_notified

> EC2 instance: (2018-08-17 12:06:15 GMT)    terminated
``

