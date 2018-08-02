
variable "DEMO_NAME" {
  default = "demo-run-container-in-vm"
}
variable "PROFILE" {
  default = "ecs-test"
}
variable "REGION" {
  default = "ap-southeast-1"
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
  default = "hyper.internal"
  description = "the internal dns name"
}

########################################################################
variable "VPC_ID" {
  default = "vpc-xxxxx" //please set a existed vpc_id
}

variable "KP" {
  default = "test-terraform"
  description = "the keypair(ssh key) to use in the EC2 machines, please create it first in test region manually"
}
variable "AMI" {
  type = "map"
  default = {
    ap-southeast-1 = "ami-68097514" #Singapore
    us-east-1 = "ami-97785bed" # Virginia
    us-west-2 = "ami-f2d3638a" # Oregon
    eu-west-1 = "ami-d834aba1" # Ireland
  }
  description = "Amazon Linux AMI 2018.03. I add only 3 regions (Singapore, Virginia, Oregon, Ireland) to show the map feature but you can add all the regions that you need"
}
