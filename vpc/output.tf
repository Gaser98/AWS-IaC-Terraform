output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}
output "public_subnet_id" {
  description = "ID of the created public subnets"
  value       = aws_subnet.public[*].id
}
output "private_subnet_id" {
  description = "ID of the created public subnets"
  value       = aws_subnet.private[*].id
}