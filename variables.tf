# Global variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

# Networking variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "availability_zones_short" {
  description = "Short AZ codes"
  type        = list(string)
}

# Bastion variables
variable "bastion_ami_id" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for Bastion"
  type        = string
  default     = "t3.micro"
}

variable "trusted_ssh_cidr" {
  description = "CIDR for SSH access to Bastion"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "bastion_instance_name" {
  description = "Name tag for Bastion instance"
  type        = string
}
