# Publiс Route table

resource "aws_route_table" "tlz_route_table_public" {
  count  = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id = aws_vpc.tlz_vpc[0].id
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.public_subnet_suffix), count.index)}-routetable-${var.location}"
    },
    var.tags
  )
}

resource "aws_route" "tlz_route_public_internet_gateway" {
  count                  = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  route_table_id         = element(aws_route_table.tlz_route_table_public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tlz_internet_gateway[0].id
  depends_on             = [aws_route_table.tlz_route_table_public, aws_internet_gateway.tlz_internet_gateway]
}

# Private route table

resource "aws_route_table" "tlz_route_table_private" {
  count  = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.tlz_vpc[0].id
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.private_subnet_suffix), count.index)}-routetable-${var.location}"
    },
    var.tags
  )
}

resource "aws_route" "tlz_route_ngw" {
  count = var.create_vpc && var.enable_nat_gateway && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  route_table_id         = element(aws_route_table.tlz_route_table_private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.tlz_nat_gateway[0].id
  depends_on             = [aws_nat_gateway.tlz_nat_gateway, aws_route_table.tlz_route_table_private]
}

# Intra route table

resource "aws_route_table" "tlz_route_table_intra" {
  count  = var.create_vpc && length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0
  vpc_id = aws_vpc.tlz_vpc[0].id
  tags = merge(
    {
      "Name" = "${var.prefix}-${var.environment}-${element(tolist(var.intra_subnet_suffix), count.index)}-routetable-${var.location}"
    },
    var.tags
  )
}

# Route table association

resource "aws_route_table_association" "tlz_route_table_association_private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = element(aws_subnet.tlz_subnet_private.*.id, count.index)
  route_table_id = element(aws_route_table.tlz_route_table_private.*.id, count.index)

  depends_on = [aws_subnet.tlz_subnet_private, aws_route_table.tlz_route_table_private]
}

resource "aws_route_table_association" "tlz_route_table_association_intra" {
  count = var.create_vpc && length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0

  subnet_id      = element(aws_subnet.tlz_subnet_intra.*.id, count.index)
  route_table_id = element(aws_route_table.tlz_route_table_intra.*.id, count.index)
  depends_on     = [aws_subnet.tlz_subnet_intra, aws_route_table.tlz_route_table_intra]
}

resource "aws_route_table_association" "tlz_route_table_association_public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.tlz_subnet_public.*.id, count.index)
  route_table_id = element(aws_route_table.tlz_route_table_public.*.id, count.index)
  depends_on     = [aws_subnet.tlz_subnet_public, aws_route_table.tlz_route_table_public]
}
