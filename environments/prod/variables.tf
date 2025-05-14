# === VPC Variables ===
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

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

# === Bastion Host Variables (Decoupled) ===
variable "bastion_ami_id" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "bastion_subnet_id" {
  description = "Subnet ID to launch Bastion"
  type        = string
}

variable "bastion_vpc_id" {
  description = "VPC ID for Bastion SG"
  type        = string
}

variable "trusted_ssh_cidr" {
  description = "CIDR for SSH access"
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

