# Internet Gateway

resource "aws_internet_gateway" "tlz_internet_gateway" {
  count  = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.tlz_vpc[0].id
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-igw-${var.location}"
    },
    var.tags
  )
}

# NAT Gateway

resource "aws_eip" "tlz_eip" {
  count = var.create_vpc && var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0
  vpc   = true
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-eip-${var.location}"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "tlz_nat_gateway" {
  count             = var.create_vpc && var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0
  allocation_id     = aws_eip.tlz_eip[0].id
  subnet_id         = aws_subnet.tlz_subnet_public[0].id
  connectivity_type = var.connectivity_type
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-ngw-${var.location}"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.tlz_internet_gateway]
}

# VPN Gateway

resource "aws_vpn_gateway" "tlz_vpn_gateway" {
  count = var.create_vpc && var.enable_vpn_gateway ? 1 : 0

  vpc_id            = aws_vpc.tlz_vpc[0].id
  amazon_side_asn   = var.amazon_side_asn
  availability_zone = var.vpn_gateway_az

  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${var.vpc_name}-vgw-${var.location}"
    }
  )
}

#resource "aws_vpn_gateway_attachment" "this" {
#  vpc_id         = aws_vpc.tlz_vpc[0].id
#  vpn_gateway_id = aws_vpn_gateway.tlz_vpn_gateway[0].id
#}
/*
resource "aws_vpn_gateway_route_propagation" "public" {
  count = var.create_vpc && var.enable_vpn_gateway ? 1 : 0
  route_table_id = element(aws_route_table.public.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.this.*.id,
      aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
    ),
    count.index,
  )
}

resource "aws_vpn_gateway_route_propagation" "private" {
  count = var.create_vpc && var.propagate_private_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.private_subnets) : 0

  route_table_id = element(aws_route_table.private.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.this.*.id,
      aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
    ),
    count.index,
  )
}

resource "aws_vpn_gateway_route_propagation" "intra" {
  count = var.create_vpc && var.propagate_intra_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.intra_subnets) : 0

  route_table_id = element(aws_route_table.intra.*.id, count.index)
  vpn_gateway_id = element(
    concat(
      aws_vpn_gateway.this.*.id,
      aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
    ),
    count.index,
  )
}
*/
