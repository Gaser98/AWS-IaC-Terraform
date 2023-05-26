output "public_instance_ids" {
  value = module.instances.public_instance_ids
}

output "private_instance_ids" {
  value = module.instances.private_instance_ids
}

output "lb_dns" {
  value = module.loadbalancer[*].lb_dns
}

