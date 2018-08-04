resource "aws_vpc_dhcp_options" "DHCP" {
    domain_name = "${var.DNS_ZONE_NAME}"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
      Name = "${var.PROJECT_NAME}-DHCP"
    }
}

resource "aws_vpc_dhcp_options_association" "DNS_RESOLVER" {
    vpc_id = "${aws_vpc.VPC.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.DHCP.id}"
}

/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "R53Zone" {
  name = "${var.DNS_ZONE_NAME}"
  vpc_id = "${aws_vpc.VPC.id}"
  comment = "${var.PROJECT_NAME}-R53Zone"
}
