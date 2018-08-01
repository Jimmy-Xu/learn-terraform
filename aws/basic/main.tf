provider "aws" {
    region = "us-east-1"
    shared_credentials_file  = "~/.aws/credentials"   //不指定的话，默认值是 "~/.aws/credentials"
    profile = "${var.profile}"  //不指定的话，默认值是 "default"
}

// existed resource
data "aws_iam_user" "test_user" {
    user_name = "ecs-test"
}

// resource to create
resource "aws_s3_bucket" "test_bucket" {
    bucket = "${var.bucket_name}"
    acl = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_iam_user.test_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
EOF
}