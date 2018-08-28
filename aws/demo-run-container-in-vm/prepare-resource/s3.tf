resource "aws_s3_bucket" "S3_BUCKET" {
  bucket = "hyper-cfg-${var.PROJECT_NAME}"
  acl    = "private"

  tags {
    Name        = "hyper-cfg-${var.PROJECT_NAME}"
    Environment = "Dev"
  }
}