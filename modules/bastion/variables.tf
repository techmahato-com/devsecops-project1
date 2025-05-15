# modules/bastion/variables.tf
variable "bastion_instance_name" {
  description = "Name tag for Bastion instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Bastion"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID to launch Bastion in"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security group"
  type        = string
}

variable "trusted_ssh_cidr" {
  description = "CIDR block allowed to SSH to Bastion"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
