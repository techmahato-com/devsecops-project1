variable "ami_id" {
  description = "AMI ID for Bastion"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where Bastion is launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for creating the security group"
  type        = string
}

variable "trusted_ssh_cidr" {
  description = "CIDR allowed to SSH into Bastion"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the Bastion EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

