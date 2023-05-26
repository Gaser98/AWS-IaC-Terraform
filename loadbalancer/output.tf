output "lb_dns" {
  description = "DNS name of the public load balancer"
  value       = aws_lb.loadbalancers[*].dns_name
}

