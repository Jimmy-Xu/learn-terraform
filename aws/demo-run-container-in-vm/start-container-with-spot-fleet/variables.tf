
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
    ap-southeast-1 = "ami-ff084815" #Singapore
    ap-northeast-1 = "ami-e8f88905" #Tokyo
    us-east-1 = "ami-ab6963d4" # Virginia
    us-west-1 = "ami-3cea065f" # California
  }
  description = "CoreOS Container Linux on EC2 - HVM (https://coreos.com/os/docs/latest/booting-on-ec2.html)"
}
