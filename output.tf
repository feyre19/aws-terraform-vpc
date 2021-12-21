output "vpc_id" {
  value       = join("", aws_vpc.tlz_vpc[*].id)
  description = "The id of VPC."
}
output "public_subnet_id" {
  value       = aws_subnet.tlz_public_subnet[*].id
  description = "The id of public subnet."
}
output "private_subnet_id" {
  value       = aws_subnet.tlz_private_subnet[*].id
  description = "The id of private subnet."
}
output "intra_subnet_id" {
  value       = aws_subnet.tlz_intra_subnet[*].id
  description = "The id of intra subnet."
}
