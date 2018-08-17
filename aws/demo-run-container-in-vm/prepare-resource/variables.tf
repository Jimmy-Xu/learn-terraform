
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

variable "VPC_FULLC_IDR" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "SUBNET-PUBLIC-AZA-CIDR" {
  default = "172.28.0.0/24"
  description = "the cidr of the subnet a"
}
variable "SUBNET-PUBLIC-AZB-CIDR" {
  default = "172.28.1.0/24"
  description = "the cidr of the subnet b"
}

variable "Subnet-Private-AzA-CIDR" {
  default = "172.28.3.0/24"
  description = "the cidr of the subnet"
}
