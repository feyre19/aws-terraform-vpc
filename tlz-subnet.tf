# Public subnet

resource "aws_subnet" "tlz_subnet_public" {
  count                           = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id                          = aws_vpc.tlz_vpc[0].id
  cidr_block                      = element(tolist(tolist(var.public_subnets)), count.index)
  availability_zone               = try(element(var.azs, count.index), null)
  assign_ipv6_address_on_creation = var.enable_ipv6 == true ? true : false
  ipv6_cidr_block                 = ((var.enable_ipv6 == true) ? cidrsubnet(aws_vpc.tlz_vpc[0].ipv6_cidr_block, 8, var.public_subnet_ipv6_prefixes[count.index]) : null)
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.public_subnet_suffix), count.index)}-subnet-${var.location}"
    },
    var.tags
  )
}

# Private subnet

resource "aws_subnet" "tlz_subnet_private" {
  count                           = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id                          = aws_vpc.tlz_vpc[0].id
  cidr_block                      = element(tolist(tolist(var.private_subnets)), count.index)
  availability_zone               = try(element(var.azs, count.index), null)
  assign_ipv6_address_on_creation = (var.enable_ipv6 == true) ? true : false
  ipv6_cidr_block                 = ((var.enable_ipv6 == true) ? cidrsubnet(aws_vpc.tlz_vpc[0].ipv6_cidr_block, 8, var.private_subnet_ipv6_prefixes[count.index]) : null)
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.private_subnet_suffix), count.index)}-subnet-${var.location}"
    },
    var.tags
  )
}

# Intra subnets - private subnet without NAT gateway

resource "aws_subnet" "tlz_subnet_intra" {
  count                           = var.create_vpc && length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0
  vpc_id                          = aws_vpc.tlz_vpc[0].id
  cidr_block                      = element(tolist(tolist(var.intra_subnets)), count.index)
  availability_zone               = try(element(var.azs, count.index), null)
  assign_ipv6_address_on_creation = (var.enable_ipv6 == true) ? true : false
  ipv6_cidr_block                 = ((var.enable_ipv6 == true) ? cidrsubnet(aws_vpc.tlz_vpc[0].ipv6_cidr_block, 8, var.intra_subnet_ipv6_prefixes[count.index]) : null)
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.intra_subnet_suffix), count.index)}-subnet-${var.location}"
    },
    var.tags
  )
}
