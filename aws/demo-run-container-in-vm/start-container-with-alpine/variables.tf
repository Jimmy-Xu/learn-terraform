
variable "PROJECT_NAME" {
  default = "demo-run-container-in-vm"
}
variable "PROFILE" {
  default = "ecs-test"
}
variable "REGION" {
  default = "us-east-1"
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
variable "AMI" {
  type = "map"
  default = {
    us-east-1 = "ami-976020ed" # alpine
  }
  description = "Alpine-3.7-r2-Hardened-EC2 - HVM (https://github.com/mcrute/alpine-ec2-ami)"
}
