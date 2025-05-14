output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.networking.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = module.networking.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "List of NAT gateway IDs"
  value       = module.networking.nat_gateway_ids
}
