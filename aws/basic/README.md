basic example for use terraform with aws provider
------------------------------------------------------

Create a s3 bucket

<!-- TOC -->

- [prepare](#prepare)
- [init workdir](#init-workdir)
- [preview change](#preview-change)
- [perform](#perform)

<!-- /TOC -->

# prepare

a profile named "ecs_test" for awscli

# init workdir

```
$ terraform init
```

# preview change

```
$ terraform plan
```

# perform

```
$ terraform apply
data.aws_iam_user.test_user: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_s3_bucket.test_bucket
      id:                            <computed>
      acceleration_status:           <computed>
      acl:                           "public-read"
      arn:                           <computed>
      bucket:                        "hyper-test-ecs-1"
      bucket_domain_name:            <computed>
      bucket_regional_domain_name:   <computed>
      cors_rule.#:                   "1"
      cors_rule.0.allowed_headers.#: "1"
      cors_rule.0.allowed_headers.0: "*"
      cors_rule.0.allowed_methods.#: "2"
      cors_rule.0.allowed_methods.0: "PUT"
      cors_rule.0.allowed_methods.1: "POST"
      cors_rule.0.allowed_origins.#: "1"
      cors_rule.0.allowed_origins.0: "*"
      cors_rule.0.expose_headers.#:  "1"
      cors_rule.0.expose_headers.0:  "ETag"
      cors_rule.0.max_age_seconds:   "3000"
      force_destroy:                 "false"
      hosted_zone_id:                <computed>
      policy:                        "..."
      region:                        <computed>
      request_payer:                 <computed>
      versioning.#:                  <computed>
      website_domain:                <computed>
      website_endpoint:              <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.test_bucket: Creating...
  acceleration_status:           "" => "<computed>"
  acl:                           "" => "public-read"
  arn:                           "" => "<computed>"
  bucket:                        "" => "hyper-test-ecs-1"
  bucket_domain_name:            "" => "<computed>"
  bucket_regional_domain_name:   "" => "<computed>"
  cors_rule.#:                   "" => "1"
  cors_rule.0.allowed_headers.#: "" => "1"
  cors_rule.0.allowed_headers.0: "" => "*"
  cors_rule.0.allowed_methods.#: "" => "2"
  cors_rule.0.allowed_methods.0: "" => "PUT"
  cors_rule.0.allowed_methods.1: "" => "POST"
  cors_rule.0.allowed_origins.#: "" => "1"
  cors_rule.0.allowed_origins.0: "" => "*"
  cors_rule.0.expose_headers.#:  "" => "1"
  cors_rule.0.expose_headers.0:  "" => "ETag"
  cors_rule.0.max_age_seconds:   "" => "3000"
  force_destroy:                 "" => "false"
  hosted_zone_id:                "" => "<computed>"
  policy:                        "" => "..."
  region:                        "" => "<computed>"
  request_payer:                 "" => "<computed>"
  versioning.#:                  "" => "<computed>"
  website_domain:                "" => "<computed>"
  website_endpoint:              "" => "<computed>"
aws_s3_bucket.test_bucket: Still creating... (10s elapsed)
aws_s3_bucket.test_bucket: Still creating... (20s elapsed)
aws_s3_bucket.test_bucket: Still creating... (30s elapsed)
aws_s3_bucket.test_bucket: Still creating... (40s elapsed)
aws_s3_bucket.test_bucket: Creation complete after 46s (ID: hyper-test-ecs-1)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```