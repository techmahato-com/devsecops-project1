# Networking outputs
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

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = module.networking.nat_gateway_id
}

# Bastion outputs
output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = module.bastion.bastion_public_ip
}

output "bastion_security_group_id" {
  description = "Security Group ID of the Bastion Host"
  value       = module.bastion.bastion_security_group_id
}
