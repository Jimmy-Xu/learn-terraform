
variable "PROJECT_NAME" {
  default = "demo-run-container-in-vm"
}
variable "PROFILE" {
  default = "ecs-test"
}
variable "REGION" {
  default = "us-east-1"
}

variable "AZS" {
  default = {
    "us-east-1" = "us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1e,us-east-1f"
    "us-west-1" = "us-west-1a,us-west-1c"
    "ap-northeast-1" = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
    "ap-southeast-1" = "ap-southeast-1a,ap-southeast-1b,ap-southeast-1c"
    # use "aws ec2 describe-availability-zones --region us-east-1 --output text"
    # to figure out the name of the AZs on every region
  }
}

/*
variable "aws_access_key" {
  default = "xxxxx"
  description = "the user aws access key"
}

variable "aws_secret_key" {
  default = "xxxx"
  description = "the user aws secret key"
}
*/
variable "CREDENTIALS_FILE" {
  default = "~/.aws/credentials" #replace your home directory
  description = "where your access and secret_key are stored, you create the file when you run the aws config"
}
variable "DNS_ZONE_NAME" {
  default = "example.io"
  description = "the internal dns name"
}

########################################################################

variable "AMI_COREOS" {
  type = "map"
  default = {
    ap-southeast-1 = "ami-ff084815" #Singapore
    ap-northeast-1 = "ami-e8f88905" #Tokyo
    us-east-1 = "ami-ab6963d4" # Virginia
    us-west-1 = "ami-3cea065f" # California
  }
  description = "CoreOS Container Linux on EC2 - HVM (https://coreos.com/os/docs/latest/booting-on-ec2.html)"
}

variable "AMI_ECS_OPTIMIZED" {
  type = "map"
  default = {
    ap-southeast-1 = "ami-091bf462afdb02c60" #Singapore
    ap-northeast-1 = "ami-0041c416aa23033a2" #Tokyo
    us-east-1 = "ami-00129b193dc81bc31" # Virginia
    us-west-1 = "ami-0d438d09af26c9583" # California
  }
  description = "Amazon ECS-Optimized AMI - (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)"
}

variable "SERVICE_NAME" {
  default = "nginx"
}
