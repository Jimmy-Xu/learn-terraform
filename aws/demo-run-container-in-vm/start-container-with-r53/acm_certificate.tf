# resource "aws_acm_certificate" "ACM_CERT" {
#   domain_name       = "${var.DNS_ZONE_NAME}"
#   validation_method = "DNS"

#   tags {
#     Name = "${var.PROJECT_NAME}-acm_cert"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }
# resource "aws_route53_record" "R53_CERT_VALIDATE" {
#   #count   = "${length(var.DNS_ZONE_NAME) + 1}"
#   count   = 1
#   name    = "${lookup(aws_acm_certificate.ACM_CERT.domain_validation_options[count.index], "resource_record_name")}"
#   type    = "${lookup(aws_acm_certificate.ACM_CERT.domain_validation_options[count.index], "resource_record_type")}"
#   zone_id = "${data.aws_route53_zone.R53Zone.zone_id}"
#   records = ["${lookup(aws_acm_certificate.ACM_CERT.domain_validation_options[count.index], "resource_record_value")}"]
#   ttl     = 30
# }

# resource "aws_acm_certificate_validation" "ACM_CERT_VALIDATE" {
#   certificate_arn = "${aws_acm_certificate.ACM_CERT.arn}"
#   validation_record_fqdns = ["${aws_route53_record.R53_CERT_VALIDATE.*.fqdn}"]
# }