<!-- BEGIN_TF_DOCS -->
## aws-terraform-vpc
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Usage
### An example to deploy VPC with supporting resources.

```hcl

module "tlz-vpc" {
  source                           = "git::https://github.com/feyre19/aws-terraform-vpc"
  create_vpc                       = var.create_vpc
  prefix                           = var.prefix
  environment                      = var.environment
  location                         = var.region_primary
  vpc_name                         = "demo"
  cidr                             = "20.10.0.0/16"
  azs                              = ["${var.region_primary}a", "${var.region_primary}b"]
  private_subnets                  = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets                   = ["20.10.11.0/24", "20.10.12.0/24"]
  intra_subnets                    = ["20.10.51.0/24", "20.10.52.0/24"]
  public_subnet_suffix             = ["publicA", "publicB"]
  private_subnet_suffix            = ["privateA", "privateB"]
  intra_subnet_suffix              = ["intraA", "intraB"]
  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_classiclink               = true
  enable_classiclink_dns_support   = true
  enable_dhcp_options              = true
  dhcp_options_domain_name         = "sample.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]
  tags                             = module.tlz-tagging.tags
}


```


## Resources

| Name | Type |
|------|------|
| [aws_eip.tlz_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.tlz_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.tlz_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.tlz_route_public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.tlz_route_ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.tlz_route_table_intra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.tlz_route_table_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.tlz_route_table_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.tlz_route_table_association_intra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.tlz_route_table_association_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.tlz_route_table_association_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.tlz_subnet_intra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tlz_subnet_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tlz_subnet_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.tlz_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.tlz_vpc_dhcp_options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.tlz_vpc_dhcp_options_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpn_gateway.tlz_vpn_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. | `string` | `null` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones names or ids in the region | `list(string)` | `[]` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | n/a | yes |
| <a name="input_connectivity_type"></a> [connectivity\_type](#input\_connectivity\_type) | (Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public. | `string` | `"public"` | no |
| <a name="input_create_igw"></a> [create\_igw](#input\_create\_igw) | Controls if an Internet Gateway is created for public subnets and the related routes that connect them. | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| <a name="input_dhcp_options_domain_name"></a> [dhcp\_options\_domain\_name](#input\_dhcp\_options\_domain\_name) | Specifies DNS name for DHCP options set (requires enable\_dhcp\_options set to true) | `string` | `""` | no |
| <a name="input_dhcp_options_domain_name_servers"></a> [dhcp\_options\_domain\_name\_servers](#input\_dhcp\_options\_domain\_name\_servers) | Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable\_dhcp\_options set to true) | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| <a name="input_dhcp_options_netbios_name_servers"></a> [dhcp\_options\_netbios\_name\_servers](#input\_dhcp\_options\_netbios\_name\_servers) | Specify a list of netbios servers for DHCP options set (requires enable\_dhcp\_options set to true) | `list(string)` | `[]` | no |
| <a name="input_dhcp_options_netbios_node_type"></a> [dhcp\_options\_netbios\_node\_type](#input\_dhcp\_options\_netbios\_node\_type) | Specify netbios node\_type for DHCP options set (requires enable\_dhcp\_options set to true) | `string` | `""` | no |
| <a name="input_dhcp_options_ntp_servers"></a> [dhcp\_options\_ntp\_servers](#input\_dhcp\_options\_ntp\_servers) | Specify a list of NTP servers for DHCP options set (requires enable\_dhcp\_options set to true) | `list(string)` | `[]` | no |
| <a name="input_enable_classiclink"></a> [enable\_classiclink](#input\_enable\_classiclink) | Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `null` | no |
| <a name="input_enable_classiclink_dns_support"></a> [enable\_classiclink\_dns\_support](#input\_enable\_classiclink\_dns\_support) | Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `null` | no |
| <a name="input_enable_dhcp_options"></a> [enable\_dhcp\_options](#input\_enable\_dhcp\_options) | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Should be true to enable DNS hostnames in the VPC | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. | `bool` | `false` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | `true` | no |
| <a name="input_enable_vpn_gateway"></a> [enable\_vpn\_gateway](#input\_enable\_vpn\_gateway) | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | An environment in which resource will be deployed. | `string` | `"dev"` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| <a name="input_intra_subnet_ipv6_prefixes"></a> [intra\_subnet\_ipv6\_prefixes](#input\_intra\_subnet\_ipv6\_prefixes) | Assigns IPv6 intra subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(string)` | `[]` | no |
| <a name="input_intra_subnet_suffix"></a> [intra\_subnet\_suffix](#input\_intra\_subnet\_suffix) | Suffix to append to intra subnets name | `list` | <pre>[<br>  "intra"<br>]</pre> | no |
| <a name="input_intra_subnets"></a> [intra\_subnets](#input\_intra\_subnets) | A list of intra subnets | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the resource is created, e.g. us-east-1. | `string` | `"us-east-1"` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Should be false if you do not want to auto-assign public IP on launch | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) A prefix for resource name e.g. tlz - Terraform Landing Zone. | `string` | n/a | yes |
| <a name="input_private_subnet_ipv6_prefixes"></a> [private\_subnet\_ipv6\_prefixes](#input\_private\_subnet\_ipv6\_prefixes) | Assigns IPv6 private subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(string)` | `[]` | no |
| <a name="input_private_subnet_suffix"></a> [private\_subnet\_suffix](#input\_private\_subnet\_suffix) | Suffix to append to private subnets name | `any` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_public_subnet_ipv6_prefixes"></a> [public\_subnet\_ipv6\_prefixes](#input\_public\_subnet\_ipv6\_prefixes) | Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(string)` | `[]` | no |
| <a name="input_public_subnet_suffix"></a> [public\_subnet\_suffix](#input\_public\_subnet\_suffix) | Suffix to append to public subnets name | `any` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Map of tags to be applied to the resource | `map(any)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name to be used on all the resources as identifier | `string` | n/a | yes |
| <a name="input_vpn_gateway_az"></a> [vpn\_gateway\_az](#input\_vpn\_gateway\_az) | The Availability Zone for the VPN Gateway | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The id of internet gateway. |
| <a name="output_intra_subnet_id"></a> [intra\_subnet\_id](#output\_intra\_subnet\_id) | The id of intra subnet. |
| <a name="output_ngw_id"></a> [ngw\_id](#output\_ngw\_id) | The id of nat gateway. |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | The id of private subnet. |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | The id of public subnet. |
| <a name="output_vgw_id"></a> [vgw\_id](#output\_vgw\_id) | The id of VPN gateway. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The id of VPC. |
<!-- END_TF_DOCS -->
