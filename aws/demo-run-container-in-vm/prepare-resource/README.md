create aws resource
---------------------

Create required aws resources: vpc, subnet, routetable, acl, igw, sg.

Set PROFILE and REGION in variables.tf first.

# Usage

```
$ terraform init

$ terraform plan

$ terraform apply
➜  prepare-resource git:(master) time terraform apply
data.aws_availability_zones.AZ_LIST: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_internet_gateway.IGW
      id:                                         <computed>
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-IGW"
      vpc_id:                                     "${aws_vpc.VPC.id}"

  + aws_network_acl.ACL
      id:                                         <computed>
      egress.#:                                   "1"
      egress.2943206146.action:                   "allow"
      egress.2943206146.cidr_block:               "0.0.0.0/0"
      egress.2943206146.from_port:                "0"
      egress.2943206146.icmp_code:                ""
      egress.2943206146.icmp_type:                ""
      egress.2943206146.ipv6_cidr_block:          ""
      egress.2943206146.protocol:                 "-1"
      egress.2943206146.rule_no:                  "2"
      egress.2943206146.to_port:                  "0"
      ingress.#:                                  "1"
      ingress.1564094202.action:                  "allow"
      ingress.1564094202.cidr_block:              "0.0.0.0/0"
      ingress.1564094202.from_port:               "0"
      ingress.1564094202.icmp_code:               ""
      ingress.1564094202.icmp_type:               ""
      ingress.1564094202.ipv6_cidr_block:         ""
      ingress.1564094202.protocol:                "-1"
      ingress.1564094202.rule_no:                 "1"
      ingress.1564094202.to_port:                 "0"
      subnet_ids.#:                               <computed>
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-ACL"
      vpc_id:                                     "${aws_vpc.VPC.id}"

  + aws_route53_zone.R53Zone
      id:                                         <computed>
      comment:                                    "demo-run-container-in-vm-R53Zone"
      force_destroy:                              "false"
      name:                                       "hyper.internal"
      name_servers.#:                             <computed>
      vpc_id:                                     "${aws_vpc.VPC.id}"
      vpc_region:                                 <computed>
      zone_id:                                    <computed>

  + aws_route_table.MAIN_RT
      id:                                         <computed>
      propagating_vgws.#:                         <computed>
      route.#:                                    "1"
      route.~742396025.cidr_block:                "0.0.0.0/0"
      route.~742396025.egress_only_gateway_id:    ""
      route.~742396025.gateway_id:                "${aws_internet_gateway.IGW.id}"
      route.~742396025.instance_id:               ""
      route.~742396025.ipv6_cidr_block:           ""
      route.~742396025.nat_gateway_id:            ""
      route.~742396025.network_interface_id:      ""
      route.~742396025.vpc_peering_connection_id: ""
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-MAIN_RT"
      vpc_id:                                     "${aws_vpc.VPC.id}"

  + aws_route_table_association.ASSOC_SUBNET_RT
      id:                                         <computed>
      route_table_id:                             "${aws_route_table.MAIN_RT.id}"
      subnet_id:                                  "${aws_subnet.PUBLIC_SUBNET.id}"

  + aws_security_group.SG
      id:                                         <computed>
      arn:                                        <computed>
      description:                                "allow http, ssh and docker"
      egress.#:                                   "1"
      egress.482069346.cidr_blocks.#:             "1"
      egress.482069346.cidr_blocks.0:             "0.0.0.0/0"
      egress.482069346.description:               ""
      egress.482069346.from_port:                 "0"
      egress.482069346.ipv6_cidr_blocks.#:        "0"
      egress.482069346.prefix_list_ids.#:         "0"
      egress.482069346.protocol:                  "-1"
      egress.482069346.security_groups.#:         "0"
      egress.482069346.self:                      "false"
      egress.482069346.to_port:                   "0"
      ingress.#:                                  "4"
      ingress.2214680975.cidr_blocks.#:           "1"
      ingress.2214680975.cidr_blocks.0:           "0.0.0.0/0"
      ingress.2214680975.description:             ""
      ingress.2214680975.from_port:               "80"
      ingress.2214680975.ipv6_cidr_blocks.#:      "0"
      ingress.2214680975.protocol:                "tcp"
      ingress.2214680975.security_groups.#:       "0"
      ingress.2214680975.self:                    "false"
      ingress.2214680975.to_port:                 "80"
      ingress.2541437006.cidr_blocks.#:           "1"
      ingress.2541437006.cidr_blocks.0:           "0.0.0.0/0"
      ingress.2541437006.description:             ""
      ingress.2541437006.from_port:               "22"
      ingress.2541437006.ipv6_cidr_blocks.#:      "0"
      ingress.2541437006.protocol:                "tcp"
      ingress.2541437006.security_groups.#:       "0"
      ingress.2541437006.self:                    "false"
      ingress.2541437006.to_port:                 "22"
      ingress.516175195.cidr_blocks.#:            "1"
      ingress.516175195.cidr_blocks.0:            "0.0.0.0/0"
      ingress.516175195.description:              ""
      ingress.516175195.from_port:                "8080"
      ingress.516175195.ipv6_cidr_blocks.#:       "0"
      ingress.516175195.protocol:                 "tcp"
      ingress.516175195.security_groups.#:        "0"
      ingress.516175195.self:                     "false"
      ingress.516175195.to_port:                  "8080"
      ingress.619371795.cidr_blocks.#:            "1"
      ingress.619371795.cidr_blocks.0:            "0.0.0.0/0"
      ingress.619371795.description:              ""
      ingress.619371795.from_port:                "2375"
      ingress.619371795.ipv6_cidr_blocks.#:       "0"
      ingress.619371795.protocol:                 "tcp"
      ingress.619371795.security_groups.#:        "0"
      ingress.619371795.self:                     "false"
      ingress.619371795.to_port:                  "2375"
      name:                                       "SG"
      owner_id:                                   <computed>
      revoke_rules_on_delete:                     "false"
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-SG"
      vpc_id:                                     "${aws_vpc.VPC.id}"

  + aws_subnet.PUBLIC_SUBNET
      id:                                         <computed>
      assign_ipv6_address_on_creation:            "false"
      availability_zone:                          "ap-southeast-1a"
      cidr_block:                                 "172.28.0.0/24"
      ipv6_cidr_block:                            <computed>
      ipv6_cidr_block_association_id:             <computed>
      map_public_ip_on_launch:                    "false"
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-PUBLIC_SUBNET"
      vpc_id:                                     "${aws_vpc.VPC.id}"

  + aws_vpc.VPC
      id:                                         <computed>
      arn:                                        <computed>
      assign_generated_ipv6_cidr_block:           "false"
      cidr_block:                                 "172.28.0.0/16"
      default_network_acl_id:                     <computed>
      default_route_table_id:                     <computed>
      default_security_group_id:                  <computed>
      dhcp_options_id:                            <computed>
      enable_classiclink:                         <computed>
      enable_classiclink_dns_support:             <computed>
      enable_dns_hostnames:                       "true"
      enable_dns_support:                         "true"
      instance_tenancy:                           "default"
      ipv6_association_id:                        <computed>
      ipv6_cidr_block:                            <computed>
      main_route_table_id:                        <computed>
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-VPC"

  + aws_vpc_dhcp_options.DHCP
      id:                                         <computed>
      domain_name:                                "hyper.internal"
      domain_name_servers.#:                      "1"
      domain_name_servers.0:                      "AmazonProvidedDNS"
      tags.%:                                     "1"
      tags.Name:                                  "demo-run-container-in-vm-DHCP"

  + aws_vpc_dhcp_options_association.DNS_RESOLVER
      id:                                         <computed>
      dhcp_options_id:                            "${aws_vpc_dhcp_options.DHCP.id}"
      vpc_id:                                     "${aws_vpc.VPC.id}"


Plan: 10 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc_dhcp_options.DHCP: Creating...
  domain_name:           "" => "hyper.internal"
  domain_name_servers.#: "" => "1"
  domain_name_servers.0: "" => "AmazonProvidedDNS"
  tags.%:                "" => "1"
  tags.Name:             "" => "demo-run-container-in-vm-DHCP"
aws_vpc.VPC: Creating...
  arn:                              "" => "<computed>"
  assign_generated_ipv6_cidr_block: "" => "false"
  cidr_block:                       "" => "172.28.0.0/16"
  default_network_acl_id:           "" => "<computed>"
  default_route_table_id:           "" => "<computed>"
  default_security_group_id:        "" => "<computed>"
  dhcp_options_id:                  "" => "<computed>"
  enable_classiclink:               "" => "<computed>"
  enable_classiclink_dns_support:   "" => "<computed>"
  enable_dns_hostnames:             "" => "true"
  enable_dns_support:               "" => "true"
  instance_tenancy:                 "" => "default"
  ipv6_association_id:              "" => "<computed>"
  ipv6_cidr_block:                  "" => "<computed>"
  main_route_table_id:              "" => "<computed>"
  tags.%:                           "" => "1"
  tags.Name:                        "" => "demo-run-container-in-vm-VPC"
aws_vpc_dhcp_options.DHCP: Creation complete after 5s (ID: dopt-812674e6)
aws_vpc.VPC: Still creating... (10s elapsed)
aws_vpc.VPC: Still creating... (20s elapsed)
aws_vpc.VPC: Creation complete after 22s (ID: vpc-b41843d3)
aws_internet_gateway.IGW: Creating...
  tags.%:    "0" => "1"
  tags.Name: "" => "demo-run-container-in-vm-IGW"
  vpc_id:    "" => "vpc-b41843d3"
aws_vpc_dhcp_options_association.DNS_RESOLVER: Creating...
  dhcp_options_id: "" => "dopt-812674e6"
  vpc_id:          "" => "vpc-b41843d3"
aws_route53_zone.R53Zone: Creating...
  comment:        "" => "demo-run-container-in-vm-R53Zone"
  force_destroy:  "" => "false"
  name:           "" => "hyper.internal"
  name_servers.#: "" => "<computed>"
  vpc_id:         "" => "vpc-b41843d3"
  vpc_region:     "" => "<computed>"
  zone_id:        "" => "<computed>"
aws_subnet.PUBLIC_SUBNET: Creating...
  assign_ipv6_address_on_creation: "" => "false"
  availability_zone:               "" => "ap-southeast-1a"
  cidr_block:                      "" => "172.28.0.0/24"
  ipv6_cidr_block:                 "" => "<computed>"
  ipv6_cidr_block_association_id:  "" => "<computed>"
  map_public_ip_on_launch:         "" => "false"
  tags.%:                          "" => "1"
  tags.Name:                       "" => "demo-run-container-in-vm-PUBLIC_SUBNET"
  vpc_id:                          "" => "vpc-b41843d3"
aws_network_acl.ACL: Creating...
  egress.#:                           "" => "1"
  egress.2943206146.action:           "" => "allow"
  egress.2943206146.cidr_block:       "" => "0.0.0.0/0"
  egress.2943206146.from_port:        "" => "0"
  egress.2943206146.icmp_code:        "" => ""
  egress.2943206146.icmp_type:        "" => ""
  egress.2943206146.ipv6_cidr_block:  "" => ""
  egress.2943206146.protocol:         "" => "-1"
  egress.2943206146.rule_no:          "" => "2"
  egress.2943206146.to_port:          "" => "0"
  ingress.#:                          "" => "1"
  ingress.1564094202.action:          "" => "allow"
  ingress.1564094202.cidr_block:      "" => "0.0.0.0/0"
  ingress.1564094202.from_port:       "" => "0"
  ingress.1564094202.icmp_code:       "" => ""
  ingress.1564094202.icmp_type:       "" => ""
  ingress.1564094202.ipv6_cidr_block: "" => ""
  ingress.1564094202.protocol:        "" => "-1"
  ingress.1564094202.rule_no:         "" => "1"
  ingress.1564094202.to_port:         "" => "0"
  subnet_ids.#:                       "" => "<computed>"
  tags.%:                             "" => "1"
  tags.Name:                          "" => "demo-run-container-in-vm-ACL"
  vpc_id:                             "" => "vpc-b41843d3"
aws_security_group.SG: Creating...
  arn:                                   "" => "<computed>"
  description:                           "" => "allow http, ssh and docker"
  egress.#:                              "" => "1"
  egress.482069346.cidr_blocks.#:        "" => "1"
  egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
  egress.482069346.description:          "" => ""
  egress.482069346.from_port:            "" => "0"
  egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
  egress.482069346.prefix_list_ids.#:    "" => "0"
  egress.482069346.protocol:             "" => "-1"
  egress.482069346.security_groups.#:    "" => "0"
  egress.482069346.self:                 "" => "false"
  egress.482069346.to_port:              "" => "0"
  ingress.#:                             "" => "4"
  ingress.2214680975.cidr_blocks.#:      "" => "1"
  ingress.2214680975.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2214680975.description:        "" => ""
  ingress.2214680975.from_port:          "" => "80"
  ingress.2214680975.ipv6_cidr_blocks.#: "" => "0"
  ingress.2214680975.protocol:           "" => "tcp"
  ingress.2214680975.security_groups.#:  "" => "0"
  ingress.2214680975.self:               "" => "false"
  ingress.2214680975.to_port:            "" => "80"
  ingress.2541437006.cidr_blocks.#:      "" => "1"
  ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2541437006.description:        "" => ""
  ingress.2541437006.from_port:          "" => "22"
  ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"
  ingress.2541437006.protocol:           "" => "tcp"
  ingress.2541437006.security_groups.#:  "" => "0"
  ingress.2541437006.self:               "" => "false"
  ingress.2541437006.to_port:            "" => "22"
  ingress.516175195.cidr_blocks.#:       "" => "1"
  ingress.516175195.cidr_blocks.0:       "" => "0.0.0.0/0"
  ingress.516175195.description:         "" => ""
  ingress.516175195.from_port:           "" => "8080"
  ingress.516175195.ipv6_cidr_blocks.#:  "" => "0"
  ingress.516175195.protocol:            "" => "tcp"
  ingress.516175195.security_groups.#:   "" => "0"
  ingress.516175195.self:                "" => "false"
  ingress.516175195.to_port:             "" => "8080"
  ingress.619371795.cidr_blocks.#:       "" => "1"
  ingress.619371795.cidr_blocks.0:       "" => "0.0.0.0/0"
  ingress.619371795.description:         "" => ""
  ingress.619371795.from_port:           "" => "2375"
  ingress.619371795.ipv6_cidr_blocks.#:  "" => "0"
  ingress.619371795.protocol:            "" => "tcp"
  ingress.619371795.security_groups.#:   "" => "0"
  ingress.619371795.self:                "" => "false"
  ingress.619371795.to_port:             "" => "2375"
  name:                                  "" => "SG"
  owner_id:                              "" => "<computed>"
  revoke_rules_on_delete:                "" => "false"
  tags.%:                                "" => "1"
  tags.Name:                             "" => "demo-run-container-in-vm-SG"
  vpc_id:                                "" => "vpc-b41843d3"
aws_vpc_dhcp_options_association.DNS_RESOLVER: Creation complete after 1s (ID: dopt-812674e6-vpc-b41843d3)
aws_subnet.PUBLIC_SUBNET: Creation complete after 7s (ID: subnet-bec7fbf7)
aws_internet_gateway.IGW: Creation complete after 8s (ID: igw-980b71fc)
aws_route_table.MAIN_RT: Creating...
  propagating_vgws.#:                         "" => "<computed>"
  route.#:                                    "" => "1"
  route.3250915861.cidr_block:                "" => "0.0.0.0/0"
  route.3250915861.egress_only_gateway_id:    "" => ""
  route.3250915861.gateway_id:                "" => "igw-980b71fc"
  route.3250915861.instance_id:               "" => ""
  route.3250915861.ipv6_cidr_block:           "" => ""
  route.3250915861.nat_gateway_id:            "" => ""
  route.3250915861.network_interface_id:      "" => ""
  route.3250915861.vpc_peering_connection_id: "" => ""
  tags.%:                                     "" => "1"
  tags.Name:                                  "" => "demo-run-container-in-vm-MAIN_RT"
  vpc_id:                                     "" => "vpc-b41843d3"
aws_route53_zone.R53Zone: Still creating... (10s elapsed)
aws_network_acl.ACL: Still creating... (10s elapsed)
aws_security_group.SG: Still creating... (10s elapsed)
aws_network_acl.ACL: Creation complete after 11s (ID: acl-7c915c1a)
aws_security_group.SG: Creation complete after 15s (ID: sg-4435833c)
aws_route_table.MAIN_RT: Creation complete after 9s (ID: rtb-6ff75809)
aws_route_table_association.ASSOC_SUBNET_RT: Creating...
  route_table_id: "" => "rtb-6ff75809"
  subnet_id:      "" => "subnet-bec7fbf7"
aws_route_table_association.ASSOC_SUBNET_RT: Creation complete after 2s (ID: rtbassoc-fee73887)
aws_route53_zone.R53Zone: Still creating... (20s elapsed)
aws_route53_zone.R53Zone: Still creating... (30s elapsed)
aws_route53_zone.R53Zone: Still creating... (40s elapsed)
aws_route53_zone.R53Zone: Still creating... (50s elapsed)
aws_route53_zone.R53Zone: Still creating... (1m0s elapsed)
aws_route53_zone.R53Zone: Creation complete after 1m9s (ID: Z192J8KITMX5HH)

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

vpc_id = vpc-b41843d3
terraform apply  1.20s user 0.55s system 1% cpu 1:58.99 total
```
