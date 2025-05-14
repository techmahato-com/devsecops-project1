output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_instance_id" {
  description = "Instance ID of the Bastion Host"
  value       = aws_instance.bastion.id
}

output "bastion_security_group_id" {
  description = "Security Group ID created for Bastion"
  value       = aws_security_group.bastion_sg.id
}

