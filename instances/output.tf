output "public_instance_ids" {
  description = "IDs of the created public instances"
  value       = aws_instance.public[*].id
}

output "private_instance_ids" {
  description = "IDs of the created private instances"
  value       = aws_instance.private[*].id
}
