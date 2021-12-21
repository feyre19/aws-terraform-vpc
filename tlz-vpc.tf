resource "aws_vpc" "tlz_vpc" {
  count = var.create_vpc ? 1 : 0
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = try(var.enable_ipv6, false)
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-${local.resource_type}-${var.location}"
    },
    var.tags
  )
}

resource "aws_vpc_dhcp_options" "tlz_vpc_dhcp_options" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0
  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-dhcp-${var.location}"
    },
    var.tags
  )
}

resource "aws_vpc_dhcp_options_association" "tlz_vpc_dhcp_options_association" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0
  vpc_id          = aws_vpc.tlz_vpc[0].id
  dhcp_options_id = aws_vpc_dhcp_options.tlz_vpc_dhcp_options[0].id
}
