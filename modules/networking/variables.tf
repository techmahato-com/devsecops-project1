variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
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
  description = "List of availability zones"
  type        = list(string)
}

variable "availability_zones_short" {
  description = "Short codes for availability zones (a, b, c)"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}


