output "vpc_id" {
  value       = join("", aws_vpc.tlz_vpc[*].id)
  description = "The id of VPC."
}
output "public_subnet_id" {
  value       = aws_subnet.tlz_subnet_public.*.id
  description = "The id of public subnet."
}
output "private_subnet_id" {
  value       = aws_subnet.tlz_subnet_private[*].id
  description = "The id of private subnet."
}
output "intra_subnet_id" {
  value       = aws_subnet.tlz_subnet_intra[*].id
  description = "The id of intra subnet."
}
output "ngw_id" {
  value       = aws_nat_gateway.tlz_nat_gateway[0].id
  description = "The id of nat gateway."
}
output "vgw_id" {
  value       = aws_vpn_gateway.tlz_vpn_gateway[0].id
  description = "The id of VPN gateway."
}
output "igw_id" {
  value       = aws_internet_gateway.tlz_internet_gateway[0].id
  description = "The id of internet gateway."
}
