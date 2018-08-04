provider "aws" {
  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  shared_credentials_file = "${var.CREDENTIALS_FILE}"
  region     = "${var.REGION}"
  profile = "${var.PROFILE}"  
}
resource "aws_vpc" "VPC" {
    cidr_block = "${var.VPC_FULLC_IDR}"
   #### this 2 true values are for use the internal vpc dns resolution
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
      Name = "${var.PROJECT_NAME}-VPC"
    }
}
